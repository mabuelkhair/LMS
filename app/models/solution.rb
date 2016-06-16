class Solution < ActiveRecord::Base
	mount_uploader :attachment, AttachmentUploader
	belongs_to :assignment
	validates :student_id, uniqueness: { scope: [:course_id, :assignment_id] }
		validates :student_id,:course_id,:assignment_id, presence: true
end
