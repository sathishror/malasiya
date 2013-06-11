class CreateIctVpns < ActiveRecord::Migration
  def self.up
    create_table :ict_vpns do |t|
      t.references :requisition_type
      t.references :user
      t.references :department
      t.string :from_date
      t.string :to_date
      t.text :justification
      t.references :system_access
      t.string :vpn_attachment
      t.text :note
      t.string :status, :default => "New"
      t.integer :forward_to
      t.text :remarks
      t.timestamps
    end
  end

  def self.down
    drop_table :ict_vpns
  end
end
