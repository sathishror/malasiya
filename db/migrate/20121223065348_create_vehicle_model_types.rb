class CreateVehicleModelTypes < ActiveRecord::Migration
  def self.up
    create_table :vehicle_model_types do |t|
      t.string :name
      t.references :sub_category
      t.boolean :is_active, :default => true
      t.boolean :deleted, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :vehicle_model_types
  end
end
