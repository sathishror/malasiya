class CreateSystemModelTypes < ActiveRecord::Migration
  def self.up
    create_table :system_model_types do |t|
      t.string :name
      t.references :system_access
      t.timestamps
    end
  end

  def self.down
    drop_table :system_model_types
  end
end
