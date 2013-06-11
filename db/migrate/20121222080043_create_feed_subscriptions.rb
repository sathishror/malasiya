class CreateFeedSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :feed_subscriptions do |t|
      t.integer :activity_feed_id
      t.integer :subscriber_id
      t.timestamps
    end
  end

  def self.down
    drop_table :feed_subscriptions
  end
end
