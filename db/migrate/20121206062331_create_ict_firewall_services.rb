class CreateIctFirewallServices < ActiveRecord::Migration
  def self.up
    create_table :ict_firewall_services do |t|
      t.references :ict_firewall
      t.references :facility_ict_service
      t.boolean :one_way
      t.boolean :approved      
      t.timestamps
    end
  end

  def self.down
    drop_table :ict_firewall_services
  end
end
