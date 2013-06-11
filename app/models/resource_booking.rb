class ResourceBooking < ActiveRecord::Base
  mount_uploader :attachment, ResourceImageUploader

#  attr_accessor :category_id,:sub_category_id
  
  #  belongs_to :bookable, :polymorphic=>true
  belongs_to :resource
  belongs_to :department

#  validates_integrity_of :attachment
#  validates_processing_of :attachment
#  validates :resource_id, :category_id, :sub_category_id, :name, :purpose, :description, :quantity, :requested_from_date, :requested_to_date, :presence=>true

end
