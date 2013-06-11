class CreateUnits < ActiveRecord::Migration
  def self.up
    create_table :units do |t|
      t.string :name
      t.references :department
      t.string :address
      t.string :telephone_number
      t.string :fax_number
      t.integer :order_by
      t.boolean :is_active, :default => true
      t.boolean :deleted, :default => false
      t.integer :created_by
      t.integer :updated_by
      t.timestamps
    end
  end

  def self.down
    drop_table :units
  end
end
