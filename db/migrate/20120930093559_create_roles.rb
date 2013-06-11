class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name
      t.boolean :is_active, :default => true
      t.boolean :deleted, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :roles
  end
end
