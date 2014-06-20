class UsersController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :find_activity, only: :read_activity

  def dashboard
  	@contacts = Contact.where(status: true)
  	@comment = Comment.new

  	if params[:assigned_to].present?
  		@tasks = User.find_by(name: params[:assigned_to]).tasks
  	else
	  	@tasks = Task.current + Task.not_due
      @tasks = Task.all if params[:sort_by] == "client"
	  end

  	if params[:sort_by] == "client"
      @task_groups = @tasks.order('due_date').group_by{ |t| t.contact.present? ? t.contact.name : "Unassigned" }
  	else
      @task_groups = @tasks.uniq.group_by{ |t| t.due_date.present? ? t.due_date.strftime("%m/%d/%y") : "Unassigned" }

  	end
  end

  def read_activity
		@activity.mark_as_read! :for => current_user
		if @activity.trackable
			case @activity.trackable.class.name
			when "Contact"
				redirect_to contact_path(@activity.trackable)
			when "Task"
				redirect_to @activity.trackable.contact.present? ? @activity.trackable.contact : root_url
			when "Comment"
				redirect_to @activity.trackable.commentable
			end
		else
			redirect_to root_path
		end
  end

  def read_all
  	Activity.mark_as_read! :all, for: current_user
  end

  def find_activity
  	@activity = Activity.find_by(uid: params[:uid])
  end
end