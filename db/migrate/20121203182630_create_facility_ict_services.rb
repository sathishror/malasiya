class CreateFacilityIctServices < ActiveRecord::Migration
  def self.up
    create_table :facility_ict_services do |t|
      t.text :name
      t.text :port
      t.boolean :is_active, :default => true
      t.boolean :deleted, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :facility_ict_services
  end
end
