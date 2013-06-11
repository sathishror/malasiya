class AgencyStore < ActiveRecord::Base
#  has_many :resource_bookings, :as=>:bookable
  belongs_to :agency  
  has_many :resources
  has_many :resource_ict_equipment_bookings
  has_many :resource_transportation_bookings

#  validates_uniqueness_of :agency_id, :sub_category_id, :resource_id, :case_sensitive=>false
 validates_uniqueness_of :resource_id, :uniqueness => {:scope => [:resource_id, :sub_category_id]}
  scope :active, where(:is_active => true, :deleted => false)
end
