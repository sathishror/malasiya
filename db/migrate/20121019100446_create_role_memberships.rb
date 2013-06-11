class CreateRoleMemberships < ActiveRecord::Migration
  def self.up
    create_table :role_memberships do |t|
      t.references :role, :user, :department,:unit
      t.string :designation
      t.boolean :default_dept, :default => false
      t.string :status
      t.integer :created_by
      t.integer :updated_by
      t.timestamps
    end
  end

  def self.down
    drop_table :role_memberships
  end
end
