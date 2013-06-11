class CreateFeedObjects < ActiveRecord::Migration
  def self.up
    create_table :feed_objects do |t|
      t.string :object_type
      t.integer :object_id
      t.string :name
      t.integer :activity_feed_id
      t.timestamps
    end
  end

  def self.down
    drop_table :feed_objects
  end
end
