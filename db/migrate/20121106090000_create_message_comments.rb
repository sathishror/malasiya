class CreateMessageComments < ActiveRecord::Migration
  def self.up
    create_table :message_comments do |t|
      t.text :comments
      t.references :message
      t.string :commenter_id
      t.timestamps
    end
  end

  def self.down
    drop_table :message_comments
  end
end
