class Quiz < ActiveRecord::Base

	has_many :questions , class_name: 'Question', foreign_key: 'quiz_id'
	belongs_to :course ,class_name: 'Course'
	validates :name ,presence: true, length: { minimum: 1 }
	validates :course_id, numericality: { only_integer: true }
end
