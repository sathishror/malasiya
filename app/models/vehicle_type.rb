class VehicleType < ActiveRecord::Base
  #Associations
  has_many :vehicles
  #has_many :resource_transportation_bookings

  #Validations
  validates :name, :presence=> true
end
