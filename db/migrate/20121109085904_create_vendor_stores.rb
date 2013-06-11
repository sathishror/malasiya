class CreateVendorStores < ActiveRecord::Migration
  def self.up
    create_table :vendor_stores do |t|
      t.references :vendor
      t.references :resources
      t.integer :quantity
      t.text :serial_no
      t.integer :uom
      t.boolean :is_active
      t.boolean :deleted, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :vendor_stores
  end
end
