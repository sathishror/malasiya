class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.text :subject
      t.text :message
      t.string :sender
      t.string :message_type
      t.integer :agency_id
      t.integer :department_id
      t.integer :unit_id
      t.string :attachment
      t.string  :file_content_type
      t.integer :file_size
      t.boolean :is_sticky_message, :default => false
      t.boolean :deleted, :default => false
      t.boolean :send_to_dept_admins, :default => false
      t.boolean :send_to_unit_admins, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
