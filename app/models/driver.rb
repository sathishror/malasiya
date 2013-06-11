class Driver < ActiveRecord::Base
  #Associations
  has_many :vehicles

  #Validations  
  validates :name,:telephone_number,:presence=> true
  validates_format_of :telephone_number, :with=>/^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/, :if=>Proc.new{|u| !u.telephone_number.blank?}
  scope :active, where(:is_active => true, :deleted => false)
end
