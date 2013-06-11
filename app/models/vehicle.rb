class Vehicle < ActiveRecord::Base
  #Associations
  belongs_to :driver  
  belongs_to :sub_category  
  
  #Validations
  validates :model_name,:registration_number,:driver_id, :presence => true
end
