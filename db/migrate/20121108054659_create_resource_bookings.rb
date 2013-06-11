class CreateResourceBookings < ActiveRecord::Migration
  def self.up
    create_table :resource_bookings do |t|
      t.references :category
      t.references :sub_category
      t.references :user
      t.references :department
      t.references :resource
      t.references :agency_store
      t.string :attachment
      t.string :purpose
      t.string :description
      t.integer :quantity
      t.datetime :requested_from_date
      t.datetime :requested_to_date
      t.datetime :request_processed_date
      t.string :status
      t.datetime :approved_date
      t.datetime :declined_date
      t.datetime :returned_date
      t.datetime :processed_date
      t.datetime :acknowledged_date
      t.boolean :is_other_agency
      t.boolean :user_returned_status
      t.boolean :priority_booking, :default=>false
      t.integer :created_by
      t.integer :updated_by
      t.timestamps
    end
  end

  def self.down
    drop_table :resource_bookings
  end
end
