class Agency < ActiveRecord::Base

  has_many :departments
  has_many :resource_managers
  has_one :agency_store
  belongs_to :user
  before_validation :strip_whitespace

  
  #validations comes here
  validates :name,:address,:telephone_number, :presence => true
  validates_uniqueness_of :name, :case_sensitive=>false, :if=>Proc.new {|u| !u.name.blank?}
  validates_format_of :telephone_number, :with=>/^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/

  validates_format_of :fax_number, :with=>/^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/, :if=>Proc.new{|u| !u.fax_number.blank?}


  #named Scopes comes here
  scope :active, where(:is_active => true, :deleted => false)
  private
    def strip_whitespace
    self.name = self.name.strip
end
   
end
