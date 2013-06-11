class Vendor < ActiveRecord::Base

  has_many :resources, :through => :resource_vendors
  
  validates :name,:address,:contact_no, :presence => true
  validates_format_of :contact_no, :with=>/^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/

  scope :active, where(:is_active => true)
end
