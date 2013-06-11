class FacilityIct < ActiveRecord::Base
  has_many :ict_hardware_bookings
  scope :active ,where(:is_active=>true, :deleted=>false)
end
