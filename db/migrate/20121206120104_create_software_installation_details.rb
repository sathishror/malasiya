class CreateSoftwareInstallationDetails < ActiveRecord::Migration
  def self.up
    create_table :software_installation_details do |t|
      t.references :software_installation
      t.references :user
      t.references :department
      t.string :name
      t.string :position
      t.string :grade
      t.boolean :approve_status
      t.text :remarks
      t.timestamps
    end
  end

  def self.down
    drop_table :software_installation_details
  end
end
