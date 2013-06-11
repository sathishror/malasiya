class Department < ActiveRecord::Base
  #  has_and_belongs_to_many :categories
  #Associations come here

  before_validation :strip_whitespace
  has_many :role_memberships 
  has_many :roles 
  has_many :users, :through => :role_memberships
  belongs_to :agency
  has_many :categories_departments
  has_many :categories, :through => :categories_departments
  has_many :resource_ict_equipment_bookings
  #Validations comes here
  validates :agency_id,:name,:address,:telephone_number, :presence => true
  validates :name, :uniqueness => {:scope => [:agency_id, :name]}
#  validates_uniqueness_of :name, :case_sensitive=>false, :if=>Proc.new {|u| !u.name.blank?}
  validates_format_of :telephone_number, :with=>/^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/
  validates_format_of :fax_number, :with=>/^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/, :if=>Proc.new{|u| !u.fax_number.blank?}
  
  #named_scopes comes here
  scope :active, where(:is_active=>true,:deleted => false).order("name asc")
  scope :all_undeleted, where(:deleted => false).order("name asc")

#  define_index do
#    indexes :name,  :sortable => true
#  end
  #  sphinx_scope(:active) {
  #    {:is_active=>true,:deleted => false, :order => 'name DESC'}
  #  }
  private
  def strip_whitespace
    self.name = self.name.strip
  end
end
