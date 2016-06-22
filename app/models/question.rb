class Question < ActiveRecord::Base

	belongs_to :quiz ,class_name: 'Quiz'

	validates :question,:quiz_id ,:weight ,presence: true
	validates :question, length: { minimum: 1 }
	validates :weight, numericality: { only_integer: false }
	validates :quiz_id, numericality: { only_integer: true }
end
