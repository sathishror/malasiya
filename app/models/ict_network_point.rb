class IctNetworkPoint < ActiveRecord::Base
  validates :requisition_type_id,:justification,:location,:quantity, :presence => true
  mount_uploader :ict_network_attachment, IctNetworkAttachmentUploader
end
