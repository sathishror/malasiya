class CreateIctHardwareBookings < ActiveRecord::Migration
  def self.up
    create_table :ict_hardware_bookings do |t|
      t.references :booker
      t.references :department
      t.references :facility_ict
      t.string :application_category
      t.timestamps
    end
  end

  def self.down
    drop_table :ict_hardware_bookings
  end
end
