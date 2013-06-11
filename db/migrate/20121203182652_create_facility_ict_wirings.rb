class CreateFacilityIctWirings < ActiveRecord::Migration
  def self.up
    create_table :facility_ict_wirings do |t|
      t.string :name
      t.boolean :is_active, :default => false
      t.boolean :deleted, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :facility_ict_wirings
  end
end
