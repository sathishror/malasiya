class CreateDeclarationProperties < ActiveRecord::Migration
  def self.up
    create_table :declaration_properties do |t|
      t.references :user
      t.string :property_file, :default => nil
      t.string :property_file1, :default => nil
      t.string :property_file2, :default => nil
      t.string :property_file3, :default => nil
      t.string :property_file4, :default => nil
      t.integer :property_year
      t.timestamps
    end
  end

  def self.down
    drop_table :declaration_properties
  end
end
