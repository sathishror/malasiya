class CreateComplaintComputers < ActiveRecord::Migration
  def self.up
    create_table :complaint_computers do |t|
      t.references :complaint_type
      t.references :system_access
      t.references :system_model_type
      t.references :user
      t.references :department
      t.integer :serial_no
      t.text :reason
      t.boolean :action_taken, :default => false
      t.string :given_date
      t.string :receipt_date
      t.text :comments
      t.references :vendor
      t.string :status, :default => "New"
      t.integer :forward_to
      t.text :remarks
      t.timestamps
    end
  end

  def self.down
    drop_table :complaint_computers
  end
end
