class CreateDrivers < ActiveRecord::Migration
  def self.up
    create_table :drivers do |t|
      t.integer :registration_id
      t.string :name
      t.string :telephone_number
      t.boolean :is_active, :default => true
      t.boolean :deleted, :default => false
      t.boolean :informed,:default=>false
      t.boolean :already_assigned,:default=> false
      t.timestamps
    end
  end

  def self.down
    drop_table :drivers
  end
end
