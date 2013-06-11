class CreateIctHardwareBookedStatuses < ActiveRecord::Migration
  def self.up
    create_table :ict_hardware_booked_statuses do |t|
      t.references :ict_hardware_booking
      t.references :ict_hardware_booked_user
      t.string :status
      t.references :approver
      t.references :officer
      t.text :remarks
      t.timestamps
    end
  end

  def self.down
    drop_table :ict_hardware_booked_statuses
  end
end
