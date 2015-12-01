class Course < ActiveRecord::Base
	belongs_to :owner , class_name: 'User'
	validates :name,:description,:privacy ,:tags,:objectives ,presence: true, length: { minimum: 1 }
	validates :name, uniqueness: true
end
