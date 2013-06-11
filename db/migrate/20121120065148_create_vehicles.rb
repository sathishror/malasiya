class CreateVehicles < ActiveRecord::Migration
  def self.up
    create_table :vehicles do |t|
      t.integer :registration_id
      t.string :registration_number      
      t.references :driver
      t.references :vehicle_type
      t.string :model_name
      t.string :registration_date
      t.boolean :alternate_driver_assigned,:default => false
      t.string  :alternate_driver_id
      t.timestamps
    end
  end

  def self.down
    drop_table :vehicles
  end
end
