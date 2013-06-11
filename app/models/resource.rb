class Resource < ActiveRecord::Base
  belongs_to :user
  belongs_to :department
  belongs_to :category
  belongs_to :sub_category
  belongs_to :agency_store
  has_many :resource_boookings
  has_many :resource_transport_bookings

#  attr_reader :type
  validates :sub_category_id, :presence=>true
  validates :resource_no, :presence=>true, :if=>Proc.new {|u| u.resource_type!="ict" }
  validates :name, :description, :brand_model ,:presence=>true, :if=>Proc.new {|u| u.resource_type=="ict" }
  validates :name, :length => { :minimum => 3 }, :if=>Proc.new {|u| !u.name.blank? && u.resource_type=="ict" }
  validates :description, :length => { :minimum => 10 }, :if=>Proc.new {|u| !u.description.blank? && u.resource_type=="ict" }
  validates :brand_model,:length => { :minimum => 4 }, :if=>Proc.new {|u| !u.brand_model.blank? && u.resource_type=="ict" }

  validates_uniqueness_of :name, :case_sensitive=>false, :if=>Proc.new {|u| !u.name.blank?}
  #validates_uniqueness_of :brand_model, :case_sensitive=>false, :if=>Proc.new {|u| !u.brand_model.blank?}
  #validates_uniqueness_of :vehicle_model, :case_sensitive=>false, :if=>Proc.new {|u| !u.vehicle_model.blank?}
  validates :resource_no, :uniqueness => {:scope => [:resource_no, :sub_category_id]}
#  validates_uniqueness_of :resource_no, :case_sensitive=>false, :if=>Proc.new {|u| !u.resource_no.blank? && (u.resource_type!="room_booking" || u.resource_type!="others"|| u.resource_type!= "ict" || u.resource_type!= "transport")}

  scope :active, where(:deleted => false)
  scope :active_ict, where(:deleted => false, :resource_type=>"ict")
  scope :active_others, where(:deleted => false, :resource_type=>"others")
  scope :active_transport, where(:deleted => false, :resource_type=>"transport")
  scope :active_room, where(:deleted => false, :resource_type=>"room_booking")
#  define_index do
#    ##indexes :name,  :sortable => true
#    indexes :category_id
#    indexes :sub_category_id
#  end
#  sphinx_scope(:active_and_subcategory) {|sub_category_id|
#    {:conditions=>{:sub_category_id => sub_category_id}}
#  }
end
