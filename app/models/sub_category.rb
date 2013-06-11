class SubCategory < ActiveRecord::Base

  before_validation :strip_whitespace
  validates :name,:category_id, :presence => true
#  validates_uniqueness_of :name, :case_sensitive=>false, :if=>Proc.new {|u| !u.name.blank?}
  validates :name, :uniqueness => {:scope => [:category_id, :name]}
  has_many :vehicles
  belongs_to :category
  has_many :resources
  has_many :resource_transportation_bookings
  has_many :resource_ict_equipment_bookings

  scope :active, where(:is_active => true, :deleted => false)
  private

  def strip_whitespace
    self.name = self.name.strip
  end
end
