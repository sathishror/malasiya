class CreateEmergencyReferences < ActiveRecord::Migration
  def self.up
    create_table :emergency_references do |t|
      t.string :name
      t.text :address
      t.string :phone_no
      t.string :relation
      t.references :user
      t.timestamps
    end
  end

  def self.down
    drop_table :emergency_references
  end
end
