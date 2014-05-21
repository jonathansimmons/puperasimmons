class Activity < PublicActivity::Activity
	include Tokenable

  acts_as_readable :on => :updated_at
end
