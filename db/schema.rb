# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121223065348) do

  create_table "activity_feeds", :force => true do |t|
    t.string   "for"
    t.string   "feed_type"
    t.integer  "actor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "agencies", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "address"
    t.string   "telephone_number"
    t.string   "fax_number"
    t.boolean  "is_active",        :default => true
    t.boolean  "deleted",          :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "agencies", ["created_at"], :name => "index_agencies_on_created_at"
  add_index "agencies", ["id", "deleted"], :name => "index_agencies_on_id_and_deleted"
  add_index "agencies", ["id", "is_active", "deleted"], :name => "index_agencies_on_id_and_is_active_and_deleted"
  add_index "agencies", ["id", "is_active"], :name => "index_agencies_on_id_and_is_active"
  add_index "agencies", ["id", "user_id"], :name => "index_agencies_on_id_and_user_id"
  add_index "agencies", ["name"], :name => "index_agencies_on_name"
  add_index "agencies", ["updated_at"], :name => "index_agencies_on_updated_at"
  add_index "agencies", ["user_id"], :name => "index_agencies_on_user_id"

  create_table "agency_stores", :force => true do |t|
    t.integer  "agency_id"
    t.integer  "category_id"
    t.integer  "sub_category_id"
    t.integer  "driver_id"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.integer  "quantity"
    t.string   "serial_no"
    t.integer  "uom"
    t.boolean  "booked",          :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "agency_stores", ["agency_id"], :name => "index_agency_stores_on_agency_id"
  add_index "agency_stores", ["category_id"], :name => "index_agency_stores_on_category_id"
  add_index "agency_stores", ["created_at"], :name => "index_agency_stores_on_created_at"
  add_index "agency_stores", ["driver_id"], :name => "index_agency_stores_on_driver_id"
  add_index "agency_stores", ["resource_id"], :name => "index_agency_stores_on_resource_id"
  add_index "agency_stores", ["serial_no"], :name => "index_agency_stores_on_serial_no"
  add_index "agency_stores", ["sub_category_id"], :name => "index_agency_stores_on_sub_category_id"
  add_index "agency_stores", ["updated_at"], :name => "index_agency_stores_on_updated_at"

  create_table "appointments", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "approvers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "department_id"
    t.boolean  "is_active",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "building_asset_types", :force => true do |t|
    t.string   "name"
    t.integer  "parent_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.boolean  "is_active",  :default => true
    t.boolean  "deleted",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_departments", :force => true do |t|
    t.integer  "category_id"
    t.integer  "department_id"
    t.boolean  "is_active",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "classifications", :force => true do |t|
    t.string   "code"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cms_pages", :force => true do |t|
    t.string   "title"
    t.string   "attachement"
    t.text     "content"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "complaint_building_assets", :force => true do |t|
    t.integer  "building_asset_type_id"
    t.integer  "user_id"
    t.integer  "department_id"
    t.integer  "type_id"
    t.integer  "item_id"
    t.string   "location"
    t.integer  "serial_no"
    t.text     "reason"
    t.boolean  "repair_action",          :default => false
    t.boolean  "spare_part_action",      :default => false
    t.boolean  "action_taken",           :default => false
    t.string   "given_date"
    t.string   "receipt_date"
    t.text     "comments"
    t.integer  "vendor_id"
    t.string   "status",                 :default => "New"
    t.integer  "forward_to"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "complaint_computers", :force => true do |t|
    t.integer  "complaint_type_id"
    t.integer  "system_access_id"
    t.integer  "system_model_type_id"
    t.integer  "user_id"
    t.integer  "department_id"
    t.integer  "serial_no"
    t.text     "reason"
    t.boolean  "action_taken",         :default => false
    t.string   "given_date"
    t.string   "receipt_date"
    t.text     "comments"
    t.integer  "vendor_id"
    t.string   "status",               :default => "New"
    t.integer  "forward_to"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "complaint_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conversations", :force => true do |t|
    t.integer  "from_userid"
    t.integer  "to_userid"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "damage_types", :force => true do |t|
    t.string   "name"
    t.integer  "parent_type_id"
    t.integer  "building_asset_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "declaration_properties", :force => true do |t|
    t.integer  "user_id"
    t.string   "property_file"
    t.string   "property_file1"
    t.string   "property_file2"
    t.string   "property_file3"
    t.string   "property_file4"
    t.integer  "property_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.integer  "agency_id"
    t.string   "address"
    t.string   "telephone_number"
    t.string   "fax_number"
    t.integer  "order_by"
    t.boolean  "is_active",        :default => true
    t.boolean  "deleted",          :default => false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "departments", ["agency_id"], :name => "index_departments_on_agency_id"
  add_index "departments", ["created_at"], :name => "index_departments_on_created_at"
  add_index "departments", ["id", "agency_id"], :name => "index_departments_on_id_and_agency_id"
  add_index "departments", ["id", "deleted"], :name => "index_departments_on_id_and_deleted"
  add_index "departments", ["id", "is_active", "deleted", "agency_id"], :name => "index_departments_on_id_and_is_active_and_deleted_and_agency_id"
  add_index "departments", ["id", "is_active", "deleted"], :name => "index_departments_on_id_and_is_active_and_deleted"
  add_index "departments", ["id", "is_active"], :name => "index_departments_on_id_and_is_active"
  add_index "departments", ["is_active", "deleted", "agency_id"], :name => "index_departments_on_is_active_and_deleted_and_agency_id"
  add_index "departments", ["name"], :name => "index_departments_on_name"
  add_index "departments", ["updated_at"], :name => "index_departments_on_updated_at"

  create_table "drivers", :force => true do |t|
    t.integer  "registration_id"
    t.string   "name"
    t.string   "telephone_number"
    t.boolean  "is_active",        :default => true
    t.boolean  "deleted",          :default => false
    t.boolean  "informed",         :default => false
    t.boolean  "already_assigned", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emergency_references", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "phone_no"
    t.string   "relation"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "equipment_categories", :force => true do |t|
    t.string   "name"
    t.boolean  "is_active",  :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facilities", :force => true do |t|
    t.string   "resource_type"
    t.integer  "sub_category_id"
    t.integer  "vehicle_id"
    t.integer  "resource_id"
    t.integer  "ict_id"
    t.text     "name"
    t.integer  "total_qty"
    t.boolean  "is_active",       :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facility_ict_agencies", :force => true do |t|
    t.string   "name"
    t.boolean  "is_active",  :default => false
    t.boolean  "deleted",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facility_ict_hardwares", :force => true do |t|
    t.string   "name"
    t.boolean  "is_active",  :default => false
    t.boolean  "deleted",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facility_ict_servers", :force => true do |t|
    t.string   "name"
    t.string   "ip"
    t.boolean  "is_active",  :default => false
    t.boolean  "deleted",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facility_ict_services", :force => true do |t|
    t.text     "name"
    t.text     "port"
    t.boolean  "is_active",  :default => true
    t.boolean  "deleted",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facility_ict_softwares", :force => true do |t|
    t.string   "name"
    t.boolean  "is_active",  :default => false
    t.boolean  "deleted",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facility_ict_wirings", :force => true do |t|
    t.string   "name"
    t.boolean  "is_active",  :default => false
    t.boolean  "deleted",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facility_icts", :force => true do |t|
    t.string   "name"
    t.boolean  "is_active",  :default => true
    t.boolean  "deleted",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feed_objects", :force => true do |t|
    t.string   "object_type"
    t.integer  "object_id"
    t.string   "name"
    t.integer  "activity_feed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feed_subscriptions", :force => true do |t|
    t.integer  "activity_feed_id"
    t.integer  "subscriber_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ict_firewall_services", :force => true do |t|
    t.integer  "ict_firewall_id"
    t.integer  "facility_ict_service_id"
    t.boolean  "one_way"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ict_firewalls", :force => true do |t|
    t.integer  "requisition_type_id"
    t.string   "source_ip"
    t.string   "destination_ip"
    t.datetime "requested_from_date"
    t.datetime "requested_to_date"
    t.text     "justification"
    t.integer  "user_id"
    t.integer  "department_id"
    t.text     "remarks"
    t.string   "status"
    t.integer  "incharge_person"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ict_hardware_booked_statuses", :force => true do |t|
    t.integer  "ict_hardware_booking_id"
    t.integer  "ict_hardware_booked_user_id"
    t.string   "status"
    t.integer  "approver_id"
    t.integer  "officer_id"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ict_hardware_booked_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "ict_hardware_booking_id"
    t.boolean  "is_replacement"
    t.boolean  "pc"
    t.boolean  "printer"
    t.boolean  "scanner"
    t.string   "status",                  :default => "New"
    t.integer  "forward_to"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ict_hardware_bookings", :force => true do |t|
    t.integer  "booker_id"
    t.integer  "department_id"
    t.integer  "facility_ict_id"
    t.string   "application_category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ict_network_points", :force => true do |t|
    t.integer  "requisition_type_id"
    t.text     "justification"
    t.string   "location"
    t.string   "quantity"
    t.integer  "user_id"
    t.integer  "department_id"
    t.integer  "hardware_id"
    t.integer  "type_id"
    t.integer  "center_id"
    t.string   "hardware_quantity"
    t.string   "work_status"
    t.text     "notes"
    t.text     "remarks"
    t.string   "ict_network_attachment"
    t.string   "status"
    t.integer  "person_incharge"
    t.string   "recommendation_type"
    t.text     "installation_info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ict_system_accesses", :force => true do |t|
    t.integer  "requisition_type_id"
    t.integer  "user_id"
    t.integer  "department_id"
    t.integer  "system_access_id"
    t.string   "system_access_attachment"
    t.string   "status",                   :default => "New"
    t.integer  "forward_to"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ict_vpns", :force => true do |t|
    t.integer  "requisition_type_id"
    t.integer  "user_id"
    t.integer  "department_id"
    t.string   "from_date"
    t.string   "to_date"
    t.text     "justification"
    t.integer  "system_access_id"
    t.string   "vpn_attachment"
    t.text     "note"
    t.string   "status",              :default => "New"
    t.integer  "forward_to"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_comments", :force => true do |t|
    t.text     "comments"
    t.integer  "message_id"
    t.string   "commenter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.text     "subject"
    t.text     "message"
    t.string   "sender"
    t.string   "message_type"
    t.integer  "agency_id"
    t.integer  "department_id"
    t.integer  "unit_id"
    t.string   "attachment"
    t.string   "file_content_type"
    t.integer  "file_size"
    t.boolean  "is_sticky_message",       :default => false
    t.boolean  "deleted",                 :default => false
    t.boolean  "send_to_dept_admins",     :default => false
    t.boolean  "send_to_unit_admins",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "sent_to_all_dept_admins", :default => false
  end

  create_table "outstations", :force => true do |t|
    t.boolean  "is_out_of_state"
    t.boolean  "is_official"
    t.string   "placename"
    t.string   "state"
    t.string   "country"
    t.string   "from_date"
    t.string   "to_date"
    t.integer  "user_id"
    t.string   "purpose"
    t.integer  "total_expenditure"
    t.string   "cause_spending"
    t.string   "attachment"
    t.string   "status"
    t.integer  "department_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requisition_types", :force => true do |t|
    t.string   "name"
    t.boolean  "is_active",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resource_bookings", :force => true do |t|
    t.integer  "category_id"
    t.integer  "sub_category_id"
    t.integer  "user_id"
    t.integer  "department_id"
    t.integer  "resource_id"
    t.integer  "agency_store_id"
    t.string   "attachment"
    t.string   "purpose"
    t.string   "description"
    t.integer  "quantity"
    t.datetime "requested_from_date"
    t.datetime "requested_to_date"
    t.datetime "request_processed_date"
    t.string   "status"
    t.datetime "approved_date"
    t.datetime "declined_date"
    t.datetime "returned_date"
    t.datetime "processed_date"
    t.datetime "acknowledged_date"
    t.boolean  "is_other_agency"
    t.boolean  "user_returned_status"
    t.boolean  "priority_booking",       :default => false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resource_ict_equipment_bookings", :force => true do |t|
    t.integer  "sub_category_id"
    t.integer  "agency_store_id"
    t.integer  "department_id"
    t.integer  "resource_id"
    t.text     "purpose"
    t.text     "location"
    t.datetime "requested_from_date"
    t.datetime "requested_to_date"
    t.boolean  "need_officer",         :default => false
    t.integer  "user_id"
    t.integer  "officer_id"
    t.integer  "approver_id"
    t.datetime "meeting_start_time"
    t.datetime "meeting_end_time"
    t.datetime "approved_date"
    t.datetime "declined_date"
    t.datetime "returned_date"
    t.datetime "processed_date"
    t.boolean  "user_returned_status"
    t.datetime "acknowledged_date"
    t.boolean  "is_other_agency"
    t.text     "notes"
    t.string   "status",               :default => "New"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resource_ict_equipment_bookings", ["agency_store_id"], :name => "index_resource_ict_equipment_bookings_on_agency_store_id"
  add_index "resource_ict_equipment_bookings", ["approver_id"], :name => "index_resource_ict_equipment_bookings_on_approver_id"
  add_index "resource_ict_equipment_bookings", ["created_at"], :name => "index_resource_ict_equipment_bookings_on_created_at"
  add_index "resource_ict_equipment_bookings", ["department_id"], :name => "index_resource_ict_equipment_bookings_on_department_id"
  add_index "resource_ict_equipment_bookings", ["id", "status"], :name => "index_resource_ict_equipment_bookings_on_id_and_status"
  add_index "resource_ict_equipment_bookings", ["officer_id"], :name => "index_resource_ict_equipment_bookings_on_officer_id"
  add_index "resource_ict_equipment_bookings", ["sub_category_id"], :name => "index_resource_ict_equipment_bookings_on_sub_category_id"
  add_index "resource_ict_equipment_bookings", ["updated_at"], :name => "index_resource_ict_equipment_bookings_on_updated_at"
  add_index "resource_ict_equipment_bookings", ["user_id"], :name => "index_resource_ict_equipment_bookings_on_user_id"

  create_table "resource_managers", :force => true do |t|
    t.integer  "agency_id"
    t.integer  "resource_id"
    t.integer  "quantity"
    t.string   "serial_no"
    t.integer  "uom"
    t.boolean  "is_active"
    t.boolean  "deleted",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resource_requisitions", :force => true do |t|
    t.integer  "requisition_type_id"
    t.text     "justification"
    t.string   "location"
    t.string   "quantity"
    t.integer  "user_id"
    t.text     "remarks"
    t.integer  "person_incharge"
    t.string   "recommendation"
    t.text     "notes"
    t.text     "installation_info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resource_room_bookings", :force => true do |t|
    t.integer  "sub_category_id"
    t.integer  "resource_id"
    t.integer  "agency_store_id"
    t.integer  "user_id"
    t.integer  "department_id"
    t.string   "requested_from_date"
    t.string   "requested_to_date"
    t.boolean  "user_returned_status"
    t.integer  "room_capacity"
    t.string   "purpose"
    t.text     "remarks"
    t.string   "room_attachment"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resource_transportation_bookings", :force => true do |t|
    t.text     "purpose"
    t.string   "state"
    t.string   "city"
    t.text     "location"
    t.integer  "number_of_passengers"
    t.string   "pick_up_place"
    t.string   "requester_id"
    t.string   "attachment"
    t.string   "status"
    t.text     "remarks"
    t.string   "approver_id"
    t.datetime "requested_from_date"
    t.datetime "requested_to_date"
    t.datetime "request_processed_date"
    t.datetime "request_returned_date"
    t.integer  "agency_store_id"
    t.integer  "sub_category_id"
    t.integer  "driver_id"
    t.integer  "department_id"
    t.boolean  "resource_returned_from_user", :default => false
    t.boolean  "send_sms_to_driver",          :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resource_vendors", :force => true do |t|
    t.integer  "resource_id"
    t.integer  "vendor_id"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resources", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.integer  "sub_category_id"
    t.integer  "vehicle_model_type_id"
    t.string   "status"
    t.string   "resource_type"
    t.string   "resource_no"
    t.text     "location"
    t.string   "vehicle_model"
    t.integer  "capacity"
    t.string   "description"
    t.string   "brand_model"
    t.boolean  "is_returnable"
    t.boolean  "is_facilty_avail",      :default => false
    t.integer  "created_by"
    t.boolean  "is_active",             :default => true
    t.boolean  "deleted",               :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resources", ["category_id"], :name => "index_resources_on_category_id"
  add_index "resources", ["created_at"], :name => "index_resources_on_created_at"
  add_index "resources", ["created_by"], :name => "index_resources_on_created_by"
  add_index "resources", ["id", "deleted"], :name => "index_resources_on_id_and_deleted"
  add_index "resources", ["id", "is_active", "deleted"], :name => "index_resources_on_id_and_is_active_and_deleted"
  add_index "resources", ["id", "is_active"], :name => "index_resources_on_id_and_is_active"
  add_index "resources", ["name"], :name => "index_resources_on_name"
  add_index "resources", ["sub_category_id"], :name => "index_resources_on_sub_category_id"
  add_index "resources", ["updated_at"], :name => "index_resources_on_updated_at"

  create_table "role_memberships", :force => true do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.integer  "department_id"
    t.integer  "unit_id"
    t.string   "designation"
    t.boolean  "default_dept",  :default => false
    t.string   "status"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "role_memberships", ["created_at"], :name => "index_role_memberships_on_created_at"
  add_index "role_memberships", ["department_id"], :name => "index_role_memberships_on_department_id"
  add_index "role_memberships", ["id", "status"], :name => "index_role_memberships_on_id_and_status"
  add_index "role_memberships", ["role_id", "user_id"], :name => "index_role_memberships_on_role_id_and_user_id"
  add_index "role_memberships", ["role_id"], :name => "index_role_memberships_on_role_id"
  add_index "role_memberships", ["unit_id"], :name => "index_role_memberships_on_unit_id"
  add_index "role_memberships", ["updated_at"], :name => "index_role_memberships_on_updated_at"
  add_index "role_memberships", ["user_id"], :name => "index_role_memberships_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.boolean  "is_active",  :default => true
    t.boolean  "deleted",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["created_at"], :name => "index_roles_on_created_at"
  add_index "roles", ["id", "deleted"], :name => "index_roles_on_id_and_deleted"
  add_index "roles", ["id", "is_active", "deleted"], :name => "index_roles_on_id_and_is_active_and_deleted"
  add_index "roles", ["id", "is_active"], :name => "index_roles_on_id_and_is_active"
  add_index "roles", ["name"], :name => "index_roles_on_name"
  add_index "roles", ["updated_at"], :name => "index_roles_on_updated_at"

  create_table "rooms", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.integer  "extension_no"
    t.boolean  "is_active",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_levels", :force => true do |t|
    t.string   "stage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_standards", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", :force => true do |t|
    t.datetime "timeline"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "software_installation_details", :force => true do |t|
    t.integer  "software_installation_id"
    t.integer  "user_id"
    t.integer  "department_id"
    t.string   "name"
    t.string   "position"
    t.string   "grade"
    t.boolean  "approve_status"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "software_installations", :force => true do |t|
    t.integer  "facility_ict_software_id"
    t.integer  "requisition_type_id"
    t.string   "status"
    t.string   "software_attachment"
    t.integer  "user_id"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", :force => true do |t|
    t.string   "name"
    t.integer  "code"
    t.string   "tel_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_categories", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.boolean  "is_active",    :default => true
    t.boolean  "is_available", :default => false
    t.boolean  "deleted",      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "system_accesses", :force => true do |t|
    t.text     "name"
    t.boolean  "is_active"
    t.integer  "complaint_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "system_model_types", :force => true do |t|
    t.string   "name"
    t.integer  "system_access_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "units", :force => true do |t|
    t.string   "name"
    t.integer  "department_id"
    t.string   "address"
    t.string   "telephone_number"
    t.string   "fax_number"
    t.integer  "order_by"
    t.boolean  "is_active",        :default => true
    t.boolean  "deleted",          :default => false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_services", :force => true do |t|
    t.integer  "user_id"
    t.text     "office_address"
    t.string   "postal_code"
    t.string   "city"
    t.string   "state"
    t.string   "office_number"
    t.string   "office_fax"
    t.string   "email"
    t.string   "recent_salary"
    t.string   "salary_scale1"
    t.string   "salary_scale2"
    t.integer  "service_level_id"
    t.integer  "classification_id"
    t.string   "grade_id"
    t.integer  "service_standard_id"
    t.integer  "appointment_id"
    t.string   "position"
    t.string   "official_position"
    t.string   "first_appointment_to_public_service"
    t.string   "first_appointment_to_present_position"
    t.string   "promotion_to_present_grade"
    t.string   "confirmation_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",       :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",       :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "ic_number"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.integer  "substantive_post_id"
    t.string   "gender"
    t.text     "address"
    t.string   "city"
    t.string   "zipcode"
    t.string   "state"
    t.string   "contact_phone"
    t.string   "contact_mobile"
    t.string   "fax_number"
    t.date     "date_of_join"
    t.date     "date_of_birth"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "avatar"
    t.datetime "avatar_updated_at"
    t.string   "status"
    t.boolean  "login_status",                          :default => false
    t.boolean  "deleted",                               :default => false
    t.string   "activation_code",        :limit => 40
    t.datetime "activated_at"
    t.boolean  "widget_one",                            :default => true
    t.boolean  "widget_two",                            :default => true
    t.boolean  "profile_status",                        :default => false
    t.string   "marital_status",                        :default => "Single"
    t.string   "hp_number"
    t.integer  "child"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["created_at"], :name => "index_users_on_created_at"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["first_name", "last_name"], :name => "index_users_on_first_name_and_last_name"
  add_index "users", ["first_name"], :name => "index_users_on_first_name"
  add_index "users", ["last_name"], :name => "index_users_on_last_name"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["updated_at"], :name => "index_users_on_updated_at"

  create_table "vehicle_model_types", :force => true do |t|
    t.string   "name"
    t.integer  "sub_category_id"
    t.boolean  "is_active",       :default => true
    t.boolean  "deleted",         :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vehicle_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vehicles", :force => true do |t|
    t.integer  "registration_id"
    t.string   "registration_number"
    t.integer  "driver_id"
    t.integer  "vehicle_type_id"
    t.string   "model_name"
    t.string   "registration_date"
    t.boolean  "alternate_driver_assigned", :default => false
    t.string   "alternate_driver_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendor_stores", :force => true do |t|
    t.integer  "vendor_id"
    t.integer  "resources_id"
    t.integer  "quantity"
    t.text     "serial_no"
    t.integer  "uom"
    t.boolean  "is_active"
    t.boolean  "deleted",      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendors", :force => true do |t|
    t.string   "name"
    t.string   "remarks"
    t.boolean  "is_active",  :default => true
    t.text     "address"
    t.text     "email"
    t.string   "contact_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
