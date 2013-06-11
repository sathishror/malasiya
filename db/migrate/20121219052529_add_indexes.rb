class AddIndexes < ActiveRecord::Migration
  def self.up
    
    add_index :agencies, :name
    add_index :agencies, :user_id
    add_index :agencies, [:id,:user_id]
    add_index :agencies, [:id,:is_active]
    add_index :agencies, [:id,:deleted]
    add_index :agencies, [:id,:is_active,:deleted]
    add_index :agencies, :created_at
    add_index :agencies, :updated_at

    add_index :agency_stores, :agency_id
    add_index :agency_stores, :category_id
    add_index :agency_stores, :sub_category_id
    add_index :agency_stores, :driver_id
    add_index :agency_stores, :resource_id
    add_index :agency_stores, :serial_no
    add_index :agency_stores, :created_at
    add_index :agency_stores, :updated_at
    
    add_index :departments, :name
    add_index :departments, :agency_id
    add_index :departments, [:id,:agency_id]
    add_index :departments, [:id,:is_active]
    add_index :departments, [:id,:deleted]
    add_index :departments, [:id,:is_active,:deleted]
    add_index :departments, [:id,:is_active,:deleted,:agency_id]
    add_index :departments, [:is_active,:deleted,:agency_id]
    add_index :departments, [:is_active,:deleted,:agency_id, :name]
    add_index :departments, :created_at
    add_index :departments, :updated_at

    add_index :resource_ict_equipment_bookings, :agency_store_id
    add_index :resource_ict_equipment_bookings, :department_id
    add_index :resource_ict_equipment_bookings, :sub_category_id
    add_index :resource_ict_equipment_bookings, :user_id
    add_index :resource_ict_equipment_bookings, :officer_id
    add_index :resource_ict_equipment_bookings, :approver_id
    add_index :resource_ict_equipment_bookings, [:id,:status]
    add_index :resource_ict_equipment_bookings, :created_at
    add_index :resource_ict_equipment_bookings, :updated_at

    add_index :resources, :name
    add_index :resources, :category_id
    add_index :resources, :sub_category_id
    add_index :resources, :created_by
    add_index :resources, [:id,:is_active]
    add_index :resources, [:id,:deleted]
    add_index :resources, [:id,:is_active,:deleted]
    add_index :resources, :created_at
    add_index :resources, :updated_at

    add_index :role_memberships, :role_id
    add_index :role_memberships, :user_id
    add_index :role_memberships, :department_id
    add_index :role_memberships, :unit_id
    add_index :role_memberships, [:id,:status]
    add_index :role_memberships, [:role_id, :user_id]
    add_index :role_memberships, :created_at
    add_index :role_memberships, :updated_at

    add_index :roles, :name
    add_index :roles, [:id,:is_active]
    add_index :roles, [:id,:deleted]
    add_index :roles, [:id,:is_active,:deleted]
    add_index :roles, :created_at
    add_index :roles, :updated_at

    add_index :users, :first_name
    add_index :users, :last_name
    add_index :users, [:first_name, :last_name]
    add_index :users, :created_at
    add_index :users, :updated_at
   
  end

  def self.down
  end
end
