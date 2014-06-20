class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :view_comments, :destroy]
  before_action :set_contact, only: [:new]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  def view_comments
    @comment = Comment.new
    @comments = @task.comments
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @comment = Comment.new

    if @task.save
      @activity = PublicActivity::Activity.create trackable: @task, key: 'task.created', owner: current_user, parameters: { url: @task.contact.present? ? contact_path(@task.contact) : root_url }, uid: Activity.new().generate_token
      Activity.find(@activity.id).mark_as_read! :for => current_user
    end

    respond_to do |format|
      format.html { redirect_to params[:return_url] || root_path }
      format.js
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    @comment = Comment.new

    if @task.update(task_params)
      if params[:quick_complete]
        if @task.completed?
          @activity = PublicActivity::Activity.create trackable: @task, key: 'task.completed', owner: current_user, parameters: {changes: @task.versions.last.changeset, url: @task.contact.present? ? contact_path(@task.contact) : root_url }, uid: Activity.new().generate_token if @task.completed
          Activity.find(@activity.id).mark_as_read! :for => current_user
        else
          @activities = Activity.where(trackable_type: "Task", trackable_id: @task.id, key: "task.completed")
          @remove_these = @activities.dup
          puts @remove_these.inspect
          @activities.delete_all
          puts @remove_these.inspect
        end
      else
        if @task.completed?
          @activity = PublicActivity::Activity.create trackable: @task, key: 'task.completed', owner: current_user, parameters: {changes: @task.versions.last.changeset, url: @task.contact.present? ? contact_path(@task.contact) : root_url }, uid: Activity.new().generate_token if @task.completed
          Activity.find(@activity.id).mark_as_read! :for => current_user
        else
          PublicActivity::Activity.where(trackable_type: "Task", trackable_id: @task.id, key: "task.completed").delete_all
          @activity = PublicActivity::Activity.create trackable: @task, key: 'task.updated', owner: current_user, parameters: {changes: @task.versions.last.changeset, url: @task.contact.present? ? contact_path(@task.contact) : root_url }, uid: Activity.new().generate_token
          Activity.find(@activity.id).mark_as_read! :for => current_user
        end
      end
    end

    respond_to do |format|
      format.html { redirect_to params[:return_url] || root_path }
      format.js
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find_by(uid: params[:id])
    end

    def set_contact
      @contact = Contact.find_by(uid: params[:contact_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params[:task][:due_date] = Chronic.parse(params[:task][:due_date]) if params[:task][:due_date].present?
      params.require(:task).permit(:content, :completed, :due_date, :contact_id, :user_id, :contact_sort, :main_sort, :uid)
    end
end
