class CreateDamageTypes < ActiveRecord::Migration
  def self.up
    create_table :damage_types do |t|
      t.string :name
      t.integer :parent_type_id
      t.references :building_asset_type
      t.timestamps
    end
  end

  def self.down
    drop_table :damage_types
  end
end
