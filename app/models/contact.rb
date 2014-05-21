class Contact < ActiveRecord::Base
  include PublicActivity::Common
	include Tokenable
	has_paper_trail ignore: [:updated_at, :created_at, :uid]
	acts_as_commentable

	enum contact_type: [ :agent, :client, :lender, :vendor ]
	enum transaction_type: [ :sale, :purchase, :lease, :sale_and_purchase, :sale_and_lease ]

	has_many :tasks


	def loop_url
		"https://www.dotloop.com/my/loops/#{loop_id}"
	end

	def to_param
		uid
	end

	def pretty_transaction
		transaction_type.gsub("_", " ").titleize
	end
end