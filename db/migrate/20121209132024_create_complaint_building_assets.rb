class CreateComplaintBuildingAssets < ActiveRecord::Migration
  def self.up
    create_table :complaint_building_assets do |t|
      t.references :building_asset_type
      t.references :user
      t.references :department
      t.integer :type_id
      t.integer :item_id
      t.string :location
      t.integer :serial_no
      t.text :reason
      t.boolean :repair_action, :default => false
      t.boolean :spare_part_action, :default => false
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
    drop_table :complaint_building_assets
  end
end
