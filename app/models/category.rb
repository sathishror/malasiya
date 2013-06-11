class Category < ActiveRecord::Base
  #  has_and_belongs_to_many :departments
  #Validation
  before_validation :strip_whitespace
  validates :name, :presence => true
  validates_uniqueness_of :name, :case_sensitive=>false, :if=>Proc.new {|u| !u.name.blank?}


  scope :active, where(:is_active => true, :deleted => false)
  scope :get_category , lambda { |*args|
    {:conditions=>["is_active=true and deleted=false and name =? ", args[0]],:limit=>1}
  }
  #Association
  has_many :categories_departments
  has_many :sub_categories
  has_many :departments, :through=>:categories_departments


  private
  def strip_whitespace
    self.name = self.name.strip
  end
  
end
