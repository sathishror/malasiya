class CreateSoftwareInstallations < ActiveRecord::Migration
  def self.up
    create_table :software_installations do |t|
      t.references :facility_ict_software
      t.references :requisition_type
      t.string :status
      t.string :software_attachment
      t.references :user
      t.integer :updated_by
      t.timestamps
    end
  end

  def self.down
    drop_table :software_installations
  end
end
