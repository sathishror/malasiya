class RequisitionType < ActiveRecord::Base
    belongs_to :ict_vpn
    belongs_to :ict_system_access
end
