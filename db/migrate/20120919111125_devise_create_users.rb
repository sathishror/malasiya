class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      t.string :ic_number
      t.string :first_name
      t.string :last_name
      t.string :username
      t.integer :substantive_post_id           
      t.string :gender
      t.text :address
      t.string :city
      t.string :zipcode
      t.string :state
      t.string :contact_phone
      t.string :contact_mobile
      t.string :fax_number      
      t.date :date_of_join
      t.date :date_of_birth    
      t.integer :created_by
      t.integer :updated_by
      t.string :avatar
      t.datetime :avatar_updated_at
      t.string :status
      t.boolean :login_status, :default => false
      t.boolean :deleted, :default => false
      t.column :activation_code, :string, :limit => 40
      t.column :activated_at, :datetime
      t.boolean :widget_one, :default => true
      t.boolean :widget_two, :default => true
      t.boolean :profile_status, :default => false
      t.string :marital_status,:default => 'Single'
      t.string :hp_number
      t.integer :child
      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end

  def self.down
    drop_table :users
  end
end
