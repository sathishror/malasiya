class IctVpn < ActiveRecord::Base
  validates :from_date, :presence => true
  validates :to_date, :presence => true

  has_many :system_accesses
  has_many :requisition_types
  belongs_to :user

 validates :requisition_type_id, :from_date, :to_date, :justification, :system_access_id, :note, :presence => true

  validate :validate_booking_time

  def validate_booking_time
    errors.add(:base,"From Date Should be greater than current date and time") if self.from_date.to_datetime!=nil && self.from_date.to_datetime < Time.now
    errors.add(:base,"To Date Should be greater than current date and time") if self.to_date.to_datetime!=nil && self.to_date.to_datetime < Time.now
    errors.add(:base,"To Date Should be greater than From date and time") if self.from_date.to_datetime!=nil && self.to_date.to_datetime!=nil && self.from_date.to_datetime > self.to_date.to_datetime
    errors.add(:base,"From Date Should be greater than current date and time") if self.from_date.to_datetime!=nil && self.from_date.to_datetime < Time.now
    end

    mount_uploader :vpn_attachment, VpnAttachmentUploader
end
