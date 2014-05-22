class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	before_action :authenticate_user!
  before_action :load_activities

 	layout :layout_by_resource


 	def load_activities
  	if user_signed_in?
	  	@activities = PublicActivity::Activity.limit(100).order(:created_at)
	  	@activity_groups = @activities.group_by{ |t| t.created_at.beginning_of_day }
	  	@unread_activities = Activity.unread_by(current_user)
	  end
  end

  protected

  def local_request?
	  false
	end
  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end


end