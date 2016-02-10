class Course < ActiveRecord::Base
	has_many :chapters , class_name: 'Chapter', foreign_key: 'course_id'
	has_many :announcements
	belongs_to :owner , class_name: 'User'
	validates :name,:description,:privacy ,:tags,:objectives ,presence: true, length: { minimum: 1 }
	validates :name, uniqueness: true
end
