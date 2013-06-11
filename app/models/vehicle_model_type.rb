class VehicleModelType < ActiveRecord::Base
  #Named scopes comes here
  scope :active, where(:is_active => true, :deleted => false)
end
