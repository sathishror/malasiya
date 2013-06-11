class CreateResourceTransportationBookings < ActiveRecord::Migration
  def self.up
    create_table :resource_transportation_bookings do |t|
      t.text :purpose
      t.string :state
      t.string :city
      t.text :location
      t.integer :number_of_passengers
      t.string :pick_up_place
      t.string :requester_id
      t.string :attachment
      t.string :status
      t.text :remarks
      t.string :approver_id      
      t.datetime :requested_from_date
      t.datetime :requested_to_date
      t.datetime :request_processed_date
      t.datetime :request_returned_date
      
      t.references :agency_store
      t.references :sub_category
      t.references :driver
      t.references :department
      t.boolean :resource_returned_from_user, :default => false
      t.boolean :send_sms_to_driver,:default=> false
      t.timestamps
    end
  end

  def self.down
    drop_table :resource_transportation_bookings
  end
end
