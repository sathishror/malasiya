class CreateAgencies < ActiveRecord::Migration
  def self.up
    create_table :agencies do |t|
      t.string :name
      t.references :user
      t.string :address
      t.string :telephone_number
      t.string :fax_number
      t.boolean :is_active, :default => true
      t.boolean :deleted, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :agencies
  end
end
