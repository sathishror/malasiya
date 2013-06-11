class CreateResourceRequisitions < ActiveRecord::Migration
  def self.up
    create_table :resource_requisitions do |t|
      t.references :requisition_type
      t.text :justification
      t.string :location
      t.string :quantity
      t.references :user
      t.text :remarks
      t.integer :person_incharge
      t.string :recommendation
      t.text :notes
      t.text :installation_info
      t.timestamps
    end
  end

  def self.down
    drop_table :resource_requisitions
  end
end
