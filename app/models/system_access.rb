class SystemAccess < ActiveRecord::Base
  belongs_to :ict_vpn
  belongs_to :ict_system_access
  belongs_to :system_access
  has_many :system_model_types
end
