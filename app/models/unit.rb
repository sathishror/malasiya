class Unit < ActiveRecord::Base
  #Association comes here
  before_validation :strip_whitespace
  has_many :role_memberships
  has_many :users, :through => :role_memberships

  attr_accessor :agency
  validates :agency, :name,:address,:telephone_number, :presence => true
  validates_uniqueness_of :name, :case_sensitive=>false, :if=>Proc.new {|u| !u.name.blank?}
  validates_format_of :telephone_number, :with=>/^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/, :if=>Proc.new{|u| !u.telephone_number.blank?}
  validates_format_of :fax_number, :with=>/^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/, :if=>Proc.new{|u| !u.fax_number.blank?}


  #Named scopes comes here
  scope :active, where(:is_active => true, :deleted => false)
  validates :department_id ,:presence=>true

   private
    def strip_whitespace
    self.name = self.name.strip
end
end
