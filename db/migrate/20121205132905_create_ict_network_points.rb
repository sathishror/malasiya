class CreateIctNetworkPoints < ActiveRecord::Migration
  def self.up
    create_table :ict_network_points do |t|
      t.references :requisition_type
      t.text :justification
      t.string :location
      t.string :quantity
      t.references :user
      t.references :department
      t.integer :hardware_id
      t.integer :type_id
      t.integer :center_id
      t.string :hardware_quantity
      t.string :work_status
      t.text :notes
      t.text :remarks
      t.string :ict_network_attachment
      t.string :status
      t.integer :person_incharge
      t.string :recommendation_type
      t.text :notes
      t.text :installation_info
      t.timestamps
    end
  end

  def self.down
    drop_table :ict_network_points
  end
end
