class IctFirewallService < ActiveRecord::Base
  belongs_to :ict_firewall
  attr_accessible :one_way,:facility_ict_service_id,:ict_firewall_id,:approved
end
