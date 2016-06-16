class Solution < ActiveRecord::Base
	mount_uploader :attachment, AttachmentUploader
	belongs_to :assignment
end
