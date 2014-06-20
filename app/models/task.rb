class Task < ActiveRecord::Base
	include Tokenable
	has_paper_trail ignore: [:updated_at, :created_at, :uid, :contact_sort, :main_sort]

	belongs_to :user
	belongs_to :contact
	acts_as_commentable

	scope :overdue, -> { where("due_date < ?", Date.today)}
	scope :current, -> { where("due_date >= ?", Date.today)}
	scope :not_due, -> { where(due_date: nil)}


	def to_param
		uid
	end
end
