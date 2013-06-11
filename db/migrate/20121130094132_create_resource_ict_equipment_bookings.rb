class CreateResourceIctEquipmentBookings < ActiveRecord::Migration
  def self.up
    create_table :resource_ict_equipment_bookings do |t|
      t.references :sub_category
      t.references :agency_store
      t.references :department
      t.references :resource
      t.text :purpose
      t.text :location
      t.datetime :requested_from_date
      t.datetime :requested_to_date
      t.boolean :need_officer, :default => false
      t.references :user
      t.references :officer
      t.references :approver
      t.datetime :meeting_start_time
      t.datetime :meeting_end_time
      t.datetime :approved_date
      t.datetime :declined_date
      t.datetime :returned_date
      t.datetime :processed_date
      t.boolean :user_returned_status
      t.datetime :acknowledged_date
      t.boolean :is_other_agency
      t.text :notes
      t.string :status, :default => "New"
      t.timestamps
    end
  end

  def self.down
    drop_table :resource_ict_equipment_bookings
  end
end
