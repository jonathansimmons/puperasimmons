class TasksController < ApplicationController
  before_action :set_task, only: [:show, :view_comments, :edit, :update, :destroy]

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

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @comment = Comment.new

    respond_to do |format|
      if @task.save
        PublicActivity::Activity.create trackable: @task, key: 'task.created', owner: current_user, parameters: { url: @task.contact.present? ? contact_path(@task.contact) : root_url }, uid: Activity.new().generate_token
        format.html { redirect_to params[:return_url] }
        format.js
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    @comment = Comment.new

    respond_to do |format|
      if @task.update(task_params)
        if params[:quick_complete]
          PublicActivity::Activity.create trackable: @task, key: 'task.updated', owner: current_user, parameters: {changes: @task.versions.last.changeset, url: @task.contact.present? ? contact_path(@task.contact) : root_url }, uid: Activity.new().generate_token if @task.completed
        else
          PublicActivity::Activity.create trackable: @task, key: 'task.updated', owner: current_user, parameters: {changes: @task.versions.last.changeset, url: @task.contact.present? ? contact_path(@task.contact) : root_url }, uid: Activity.new().generate_token
        end
        format.html { redirect_to params[:return_url] }
        format.js
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params[:task][:due_date] = Chronic.parse(params[:task][:due_date]) if params[:task][:due_date].present?
      params.require(:task).permit(:content, :completed, :due_date, :contact_id, :user_id, :contact_sort, :main_sort, :uid)
    end
end
