class CreateIctFirewalls < ActiveRecord::Migration
  def self.up
    create_table :ict_firewalls do |t|
      t.references :requisition_type
      t.string :source_ip
      t.string :destination_ip      
      t.datetime :requested_from_date
      t.datetime :requested_to_date
      t.text :justification
      t.references :user
      t.references :department
      t.text :remarks
      t.string :status
      t.integer :incharge_person
      t.timestamps
    end
  end

  def self.down
    drop_table :ict_firewalls
  end
end
