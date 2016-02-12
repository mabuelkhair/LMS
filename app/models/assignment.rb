class Assignment < ActiveRecord::Base
	belongs_to :course
	mount_uploader :attachment, AttachmentUploader
end
