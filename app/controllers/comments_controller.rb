class CommentsController < ApplicationController
	before_action :find_contact, only: [:create]
	before_action :find_comment, only: [:update, :destroy]

  def create
  	@contact.comments.create(comment: params[:comment][:comment], user_id: current_user.id)
  end

  def update
  	 @contact.comments.create(comment: params[:comment])
  end

  def destroy
  	@comment.destroy
  end

  private

  def find_contact
  	@comment = Contact.find(params[:comment_id])
  end

  def find_contact
  	@contact = Contact.find_by(uid: params[:comment][:contact_id])
  end
end
