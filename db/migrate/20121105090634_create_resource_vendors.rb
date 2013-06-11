class CreateResourceVendors < ActiveRecord::Migration
  def self.up
    create_table :resource_vendors do |t|
      t.references :resource
      t.references :vendor
      t.integer :created_by
      t.timestamps
    end
  end

  def self.down
    drop_table :resource_vendors
  end
end
