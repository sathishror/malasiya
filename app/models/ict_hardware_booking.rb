class IctHardwareBooking < ActiveRecord::Base
  has_many :ict_hardware_booked_users
  belongs_to :facility_ict
  belongs_to :booker, :class_name => "User", :foreign_key => "booker_id"
  belongs_to :department
  accepts_nested_attributes_for :ict_hardware_booked_users#, :reject_if => proc { |attributes| attributes['user_id'].blank?  || attributes['is_replacement'].blank? }

  validates_associated :ict_hardware_booked_users
  validates :ict_hardware_booked_users ,:presence=>true
end
