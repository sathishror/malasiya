class CreateComplaintTypes < ActiveRecord::Migration
  def self.up
    create_table :complaint_types do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :complaint_types
  end
end
