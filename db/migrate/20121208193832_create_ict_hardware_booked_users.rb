class CreateIctHardwareBookedUsers < ActiveRecord::Migration
  def self.up
    create_table :ict_hardware_booked_users do |t|
      t.references :user
      t.references :ict_hardware_booking
      t.boolean :is_replacement
      t.boolean :pc
      t.boolean :printer
      t.boolean :scanner
      t.string :status, :default => "New"
      t.integer :forward_to
      t.text :remarks
      t.timestamps
    end
  end

  def self.down
    drop_table :ict_hardware_booked_users
  end
end
