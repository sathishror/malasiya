class CreateIctSystemAccesses < ActiveRecord::Migration
  def self.up
    create_table :ict_system_accesses do |t|

      t.references :requisition_type
      t.references :user
      t.references :department
      t.references :system_access
      t.string :system_access_attachment
      t.string :status, :default => "New"
      t.integer :forward_to
      t.text :remarks
      t.timestamps
    end
  end

  def self.down
    drop_table :ict_system_accesses
  end
end
