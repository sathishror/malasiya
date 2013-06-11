class CreateActivityFeeds < ActiveRecord::Migration
  def self.up
    create_table :activity_feeds do |t|
      t.string :for
      t.string :feed_type
      t.integer :actor_id
      t.timestamps
    end
  end

  def self.down
    drop_table :activity_feeds
  end
end
