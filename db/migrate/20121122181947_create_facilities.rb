class CreateFacilities < ActiveRecord::Migration
  def self.up
    create_table :facilities do |t|
      t.string :resource_type
      t.references :sub_category
      t.integer :vehicle_id
      t.references :resource
      t.integer :ict_id
      t.text :name
      t.integer :total_qty
      t.boolean :is_active, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :facilities
  end
end
