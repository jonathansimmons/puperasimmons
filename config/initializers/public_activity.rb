PublicActivity::Activity.class_eval do
	has_many :activities, :dependent => :destroy
	has_many :tasks, through: :activities
	has_many :comments, through: :activities
	has_many :contacts, through: :activities
end