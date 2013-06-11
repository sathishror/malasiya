class CreateResourceManagers < ActiveRecord::Migration
  def self.up
    create_table :resource_managers do |t|
      t.references :agency
      t.references :resource
      t.integer :quantity
      t.string :serial_no
      t.integer :uom
      t.boolean :is_active
      t.boolean :deleted, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :resource_managers
  end
end
