class CommentsController < ApplicationController
	before_action :find_contact, only: :create
  before_action :find_task, only: :create
	before_action :find_comment, only: :destroy

  def edit
  end

  def create
    if @contact.present?
    	@comment = @contact.comments.create(comment: params[:comment][:comment], user_id: current_user.id)
      @contact.create_activity key: 'contact.comment_on', owner: current_user
      @activity = PublicActivity::Activity.create trackable: @contact, key: 'task.comment_on', owner: current_user, uid: Activity.new().generate_token
      @activity.mark_as_read! :for => current_user
    elsif @task.present?
      @comment = @task.comments.create(comment: params[:comment][:comment], user_id: current_user.id)
      @activity = PublicActivity::Activity.create(trackable: @task, key: 'task.comment_on', owner: current_user, uid: Activity.new().generate_token)
      @activity.mark_as_read! :for => current_user
    end
  end

  def destroy
  	@comment.destroy
  end

  private

  def find_comment
  	@comment = Comment.find(params[:id])
  end

  def find_contact
  	@contact = Contact.find_by(uid: params[:comment][:contact_id])
  end

  def find_task
    @task = Task.find_by(uid: params[:comment][:task_id])
  end
end
