class MessageComment < ActiveRecord::Base
  belongs_to :message
  belongs_to :user, :foreign_key => 'commenter_id'
  attr_accessible :comments,:message_id,:commenter_id  
end
