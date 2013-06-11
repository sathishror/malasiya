class CreateResources < ActiveRecord::Migration
  def self.up
    create_table :resources do |t|
      t.string :name
      t.references :category
      t.references :sub_category
      t.references :vehicle_model_type
      t.string :status
      t.string :resource_type
      t.string :resource_no
      t.text :location
      t.string :vehicle_model
      t.integer :capacity
      t.string :description
      t.string :brand_model
      t.boolean :is_returnable
      t.boolean :is_facilty_avail, :default => false
      t.integer :created_by
      t.boolean :is_active, :default => true
      t.boolean :deleted, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :resources
  end
end
