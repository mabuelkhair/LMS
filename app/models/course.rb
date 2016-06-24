class Course < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader
	has_many :chapters , class_name: 'Chapter', foreign_key: 'course_id'
	has_many :announcements
	has_many :assignments
	has_many :quizzes , class_name: 'Quiz', foreign_key: 'course_id'

	belongs_to :owner , class_name: 'User'

  	has_and_belongs_to_many :students, :class_name =>"User"

	validates :name,:description,:privacy ,:tags,:objectives ,presence: true, length: { minimum: 1 }
	validates :name, uniqueness: true
end
