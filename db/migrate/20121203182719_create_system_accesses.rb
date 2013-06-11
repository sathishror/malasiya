class CreateSystemAccesses < ActiveRecord::Migration
  def self.up
    create_table :system_accesses do |t|
      t.text :name
      t.boolean :is_active
      t.references :complaint_type
      t.timestamps
    end
  end

  def self.down
    drop_table :system_accesses
  end
end
