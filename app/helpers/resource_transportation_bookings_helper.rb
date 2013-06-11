module ResourceTransportationBookingsHelper

  # This method is for status 'Approved' alone
  def approve_scenario(id,vehicle_id)

    rtb = ResourceTransportationBooking.find(id)
    agency_store = AgencyStore.find_by_resource_id(vehicle_id)
    driver = Driver.find(agency_store.driver_id)
    #vehicle = Vehicle.find(vehicle_id)
    #driver = Driver.find(vehicle.driver_id)
      
    rtb.update_attributes(:status=>'Approved',:agency_store_id => agency_store.id,:driver_id => driver.id)
    agency_store.update_attribute(:booked,true)
    driver.update_attribute(:already_assigned,true)

    disable_the_sub_category_when_that_sub_category_is_fully_reserved(agency_store.sub_category_id)
      
  end

  # This method is for status 'Returned' alone
  def return_scenario(id)

    rtb = ResourceTransportationBooking.find(id)
    agency_store = AgencyStore.find(rtb.agency_store_id)    
    driver = Driver.find(agency_store.driver_id)

    if rtb.driver_id != agency_store.driver_id
      new_agency_store = AgencyStore.find_by_driver_id(rtb.driver_id)
      new_driver = Driver.find(new_agency_store.driver_id)
      new_driver.update_attribute(:already_assigned,false)
      new_agency_store.update_attribute(:booked,false)      
    end

    #    vehicle = Vehicle.find(agency_store.resource_id)
    #    if vehicle.alternate_driver_assigned?
    #      driver = Driver.find(vehicle.alternate_driver_id)
    #      vehicle.update_attributes(:alternate_driver_assigned=>false,:alternate_driver_id=>nil)
    #    else
    #      driver = Driver.find(vehicle.driver_id)
    #    end
    driver.update_attribute(:already_assigned,false)
    agency_store.update_attribute(:booked,false)
    rtb.update_attributes(:status=>'Returned',:request_returned_date=>Time.now)
    
    #driver.update_attribute(:already_assigned,false)

    disable_the_sub_category_when_that_sub_category_is_fully_reserved(agency_store.sub_category_id)
  end

  def get_booking_records
    if current_user && current_user.is_super_admin?
      @resource_transportation_bookings = ResourceTransportationBooking.all
    elsif current_user && current_user.is_resource_manager?
      @resource_transportation_bookings = ResourceTransportationBooking.find(:all,:conditions=>["status = 'Approved' or status = 'Processed' or status = 'Returned' "])
    else
      @resource_transportation_bookings = ResourceTransportationBooking.find(:all,:conditions=>[("requester_id = '#{current_user.id}'")])
    end
  end

  def process_scenario_alternate_driver(id,driver_name)
    rtb = ResourceTransportationBooking.find(id)
    driver = Driver.find_by_name(driver_name)
    
    as = AgencyStore.find(rtb.agency_store_id)
    as1 = AgencyStore.find_by_driver_id(driver.id)

    vehicle_driver = Driver.find(as.driver_id)

    rtb.update_attributes(:status=>'Processed',:request_processed_date=>Time.now,:driver_id=>driver.id)
    #vehicle_driver.update_attribute(:already_assigned,false)
    as1.update_attribute(:booked,true)
    driver.update_attribute(:already_assigned,true)

    # disable_the_sub_category_when_that_sub_category_is_fully_reserved(id)
    
  end

  def decline_scenario(id)
    rtb = ResourceTransportationBooking.find(id)
    as = AgencyStore.find(rtb.agency_store_id)
    as.update_attribute(:booked,false)
    disable_the_sub_category_when_that_sub_category_is_fully_reserved(rtb.sub_category_id)
  end

  def allocate_resource_for_super_admin_request(rtb,sub_category_id)
    a = AgencyStore.where(:sub_category_id=>"#{sub_category_id}",:booked => false).first
    if !a.blank?
      rtb.agency_store_id = a.id
      rtb.driver_id = a.driver_id
      a.update_attributes(:booked=>true)
    else
      last_rtb = ResourceTransportationBooking.where(:sub_category_id=>"#{sub_category_id}").last
      last_rtb.update_attributes(:status => 'Cancelled')
      rtb.agency_store_id = last_rtb.agency_store_id
      rtb.driver_id = last_rtb.driver_id
    end
    rtb.save
    disable_the_sub_category_when_that_sub_category_is_fully_reserved(sub_category_id)
  end

  def disable_the_sub_category_when_that_sub_category_is_fully_reserved(id)
    ag = AgencyStore.find(:all,:conditions=>["booked = false and sub_category_id = ?",id])
    sc = SubCategory.find(id)
    if ag.count > 0      
      sc.update_attribute(:is_available,true)
    else
      sc.update_attribute(:is_available,false)
    end
  end 
end
