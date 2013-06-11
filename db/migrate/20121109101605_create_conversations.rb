class CreateConversations < ActiveRecord::Migration
  def self.up
    create_table :conversations do |t|
    
      t.integer :from_userid
      t.integer :to_userid
    
      t.text :content  
      t.timestamps
    end
  end

  def self.down
    drop_table :conversations
  end
end
