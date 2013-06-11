class CreateFacilityIctServers < ActiveRecord::Migration
  def self.up
    create_table :facility_ict_servers do |t|
      t.string :name
      t.string :ip
      t.boolean :is_active, :default => false
      t.boolean :deleted, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :facility_ict_servers
  end
end
