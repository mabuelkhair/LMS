class Assignment < ActiveRecord::Base
	belongs_to :course
	has_many :solutions
	mount_uploader :attachment, AttachmentUploader
	validates :name,:description,:due_date ,presence: true

	validate :due_date_cannot_be_in_the_past
  def due_date_cannot_be_in_the_past
    errors.add(:due_date, "can't be in the past") if
      !due_date.blank? and due_date < Date.today
  end
end
