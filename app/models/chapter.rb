class Chapter < ActiveRecord::Base
	has_many :contents , class_name: 'Content', foreign_key: 'chapter_id'
	belongs_to :course , class_name: 'Course'
	validates_uniqueness_of :name, :scope => [:course_id]
	validates :name,:description,presence: true, length: { minimum: 1 }
end
