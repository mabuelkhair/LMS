class CreateCourse < ActiveRecord::Base
	belongs_to :user
	validates :name,:description,:privacy ,:tags,:objectives ,presence: true, length: { minimum: 1 }
	validates :name, uniqueness: true
end
