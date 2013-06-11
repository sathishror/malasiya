class CreateEquipmentCategories < ActiveRecord::Migration
  def self.up
    create_table :equipment_categories do |t|
      t.string :name
      t.boolean :is_active, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :equipment_categories
  end
end
