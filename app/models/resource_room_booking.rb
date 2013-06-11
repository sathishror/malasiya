class ResourceRoomBooking < ActiveRecord::Base
#  validates :room_type_id, :presence => true
  validates :requested_from_date, :presence => true
  validates :requested_to_date, :presence => true
  validates :room_capacity, :presence => true
  validates :purpose, :presence => true
  mount_uploader :room_attachment, RoomAttachmentUploader

end
