class Conversation < ActiveRecord::Base
  belongs_to :user, :counter_cache => true

  scope:convos, lambda { |*args|
    {:conditions=>["(from_userid =? and to_userid=?) or ((from_userid =? and to_userid=?))", args[0],args[1],args[1],args[0]]}
  }
  
end
