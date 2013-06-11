class IctHardwareBookedUser < ActiveRecord::Base
#  has_many :ict_hardware_booked_statuses
  belongs_to :ict_hardware_booking
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  belongs_to :officer, :class_name => "User", :foreign_key => "forward_to"

#  accepts_nested_attributes_for :ict_hardware_booked_statuses

  validates :user_id, :presence=>true
  validate :booking
  
  def booking
    errors.add(:base,"Select if hardware is replacement or new") if self.is_replacement.nil?
    errors.add(:base,"Select atleast one required hardware for requistion") if self.pc.blank? && self.printer.blank? && self.scanner.blank?
  end


end
