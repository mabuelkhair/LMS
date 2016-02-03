class Chapter < ActiveRecord::Base
	belongs_to :course , class_name: 'Course'
end
