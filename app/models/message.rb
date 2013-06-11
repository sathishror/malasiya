class Message < ActiveRecord::Base
  has_many :message_comments
  belongs_to :user, :foreign_key => 'sender'
  #validates :message, :presence => true
  attr_accessible :type,:sender,:message,:agency_id,:department_id,:attachment,:unit_id
  mount_uploader :attachment, AttachmentUploader
end
