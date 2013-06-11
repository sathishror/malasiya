class IctSystemAccess < ActiveRecord::Base
  mount_uploader :system_access_attachment, SystemAccessAttachmentUploader
  has_many :system_accesses
  has_many :requisition_types
  
  belongs_to :user

  validates :requisition_type_id, :system_access_id, :presence => true
end
