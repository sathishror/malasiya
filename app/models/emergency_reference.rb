class EmergencyReference < ActiveRecord::Base
  validates :name, :address, :phone_no, :relation, :presence=>true
end
