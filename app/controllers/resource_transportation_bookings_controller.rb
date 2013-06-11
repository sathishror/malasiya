class ResourceTransportationBookingsController < ApplicationController
  before_filter :authenticate_user!
  include ResourceTransportationBookingsHelper
  
  def index
    get_booking_records
  end

  def new
    @resource_transportation_booking = ResourceTransportationBooking.new
    if !current_user.is_super_admin?
      @category = CategoriesDepartments.where(:category_id => 7,:department_id => current_user.role_memberships.where(:default_dept => true).first.department.id)
      @sub_category = SubCategory.where(:category_id => 7,:is_available => true )
    end
    #@if_inside_agency = AgencyStore.where(:category_id=> 7,:booked=> false,:agency_id => current_user.departments.collect(&:agency_id).join(','))
  end
  
  def get_vehicle_brands
    vehicle_brands =params[:sub_category_id] ? VehicleModelType.active.where("sub_category_id =?",params[:sub_category_id]) : nil
    render :json=>[vehicle_brands] if vehicle_brands
  end
  
  def get_booked_and_available_vehicles
    booked_vehicles = Resource.find_by_sql "SELECT * FROM `resources` INNER JOIN agency_stores ON resources.id = agency_stores.resource_id
                                            WHERE agency_stores.booked = true
                                            AND resources.vehicle_model_type_id =#{params[:vehicle_model_type_id]}"
                                            
    available_vehicles = Resource.find_by_sql "SELECT * FROM `resources` INNER JOIN agency_stores ON resources.id = agency_stores.resource_id
                                               WHERE agency_stores.booked = false
                                               AND resources.vehicle_model_type_id =#{params[:vehicle_model_type_id]}"                                         
    render :json =>{ :booked => booked_vehicles, :available => available_vehicles} 
  end
  
  def get_vehicles    
    vehicles = Resource.find_by_sql "SELECT * FROM `resources` INNER JOIN agency_stores ON resources.id = agency_stores.resource_id
                                     WHERE agency_stores.booked = false
                                     AND agency_stores.agency_id =#{current_user.departments[0].agency.id}
                                     AND resources.vehicle_model_type_id =#{params[:vehicle_model_type_id]}"
    
    render :json=>[vehicles] if vehicles
  end

  def create
    @resource_transportation_booking = ResourceTransportationBooking.new(params[:resource_transportation_booking])
    if @resource_transportation_booking.valid?
      if !current_user.is_super_admin?
        @resource_transportation_booking.status = "New"
        @resource_transportation_booking.department_id = current_user.role_memberships.where(:default_dept => true).first.department.id
      else
        @resource_transportation_booking.status = "Processed"
        @resource_transportation_booking.department_id = '0'
        if params[:vehicle][:model_type_id_available] != ''
          agency_store = AgencyStore.find_by_resource_id(params[:vehicle][:model_type_id_available])
          @resource_transportation_booking.agency_store_id = agency_store.id
          @resource_transportation_booking.driver_id = agency_store.driver_id
          agency_store.update_attributes(:booked=>true)
        else
          agency_store = AgencyStore.find_by_resource_id(params[:vehicle][:model_type_id_booked])
          rtb_old = ResourceTransportationBooking.find_by_agency_store_id(agency_store.id)
          rtb_old.update_attributes(:status => 'Cancelled')
          @resource_transportation_booking.agency_store_id = rtb_old.agency_store_id
          @resource_transportation_booking.driver_id = rtb_old.driver_id      
          agency_store.update_attributes(:booked=>true)    
        end
        #allocate_resource_for_super_admin_request(@resource_transportation_booking,params[:resource_transportation_booking][:sub_category_id])        
      end
      @resource_transportation_booking.requester_id = current_user.id
      @resource_transportation_booking.requested_from_date = (params[:resource_transportation_booking][:requested_from_date]).to_datetime
      @resource_transportation_booking.requested_to_date = (params[:resource_transportation_booking][:requested_to_date]).to_datetime
      @resource_transportation_booking.save

      if !current_user.is_super_admin?
      @approve = Approver.active.find_all_by_department_id(current_user.departments).first
      @approve_second = Approver.active.find_all_by_department_id(current_user.departments).last
              
        if @approve.present?
          UserMailer.send_mail_to_dept_admin_for_transport_booking(@approve,@resource_transportation_booking,@resource_transportation_booking.department_id).deliver
          #Stalker.enqueue("#{SPREFIX}.transport.booking", :booking_id => @resource_transportation_booking.id, :user=> @approve.user_id)
        elsif @approve_second.present?
          UserMailer.send_mail_to_dept_admin_for_transport_booking(@approve_second,@resource_transportation_booking,@resource_transportation_booking.department_id).deliver
          #Stalker.enqueue("#{SPREFIX}.transport.booking", :booking_id => @resource_transportation_booking.id, :user=> @approve_second.user_id)
        else
          dept = Department.find_by_id(params[:department_id])
          user = dept.users.where("role_id = 2").first
          UserMailer.send_mail_to_dept_admin_for_transport_booking(user,@resource_transportation_booking,@resource_transportation_booking.department_id).deliver
          #Stalker.enqueue("#{SPREFIX}.transport.booking", :booking_id => @resource_transportation_booking.id, :user=> user.id)
        end
      end

      redirect_to(resource_transportation_bookings_path, :notice => "Your Transport booking has been created sucessfully.")
    else
      if !current_user.is_super_admin?
        @category = CategoriesDepartments.where(:category_id=> 7,:department_id=> current_user.role_memberships.where(:default_dept => true).first.department.id)
        @sub_category = SubCategory.where(:category_id => 7,:is_available => true)
      end
      #@if_inside_agency = AgencyStore.where(:category_id=> 7,:booked=> false,:agency_id => current_user.departments.collect(&:agency_id).join(','))
      render :action=>'new'
    end
  end

  # For Approval
  def approve_request
    if current_user.is_resource_manager?
      @resource_transportation_bookings = ResourceTransportationBooking.find(:all, :conditions => ["status != 'New'"])
      #@resource_transportation_bookings = ResourceTransportationBooking.find_all_by_department_id(current_user.departments, :conditions => ["status != 'New'"])
    else
      @approver = Approver.active.find_all_by_department_id(current_user.departments).first
      @approver_second = Approver.active.find_all_by_department_id(current_user.departments).last
      if @approver.present? && @approver.user_id == current_user.id
        @resource_transportation_bookings = ResourceTransportationBooking.find_all_by_department_id(@approver.department_id)
      elsif @approver_second.present? && @approver_second.user_id == current_user.id
        @resource_transportation_bookings = ResourceTransportationBooking.where(:department_id => @approver_second.department_id)
      else
        @resource_transportation_bookings = ResourceTransportationBooking.where(:department_id => current_user.departments)
      end
    end
  end

  def show
    @resource_transportation_booking = ResourceTransportationBooking.find(params[:id])
    @requester = User.find("#{@resource_transportation_booking.requester_id}")
  end

  def request_view
    @resource_transportation_booking = ResourceTransportationBooking.find(params[:id])
    @requester = User.find("#{@resource_transportation_booking.requester_id}")
  end

  # Resource Transportation Booking Tracking Method
  def change_resource_status
    @resource_transportation_booking = ResourceTransportationBooking.find(params[:id])    

    if params[:approve_status] == "Approved"
      
      approve_scenario(params[:id],params[:vehicle][:id])      

    elsif params[:approve_status] == "Processed"

      if params[:driver][:name] && params[:driver][:name] != ''
        process_scenario_alternate_driver(params[:id],params[:driver][:name])
      else
        @resource_transportation_booking.update_attribute(:status,"Processed")
      end
      
    elsif params[:approve_status] == "Returned"
      return_scenario(params[:id])
    elsif params[:approve_status] == "Declined"
      if @resource_transportation_booking.status == "Approved"
        decline_scenario(params[:id])      
      end
      @resource_transportation_booking.update_attribute(:status,'Declined')
    end
    
    redirect_to(approve_request_resource_transportation_bookings_path, :notice => 'Transport Booking Status has been successfully updated.')
  end

  # Retrieve the Vehicles List for the Vehicle Type
  #def get_vehicles
    #vehicles = Vehicle.where(:vehicle_type_id => params[:vehicle_type_id])
    #render :json=>[vehicles] if vehicles
  #end

  # Retrieving Driver Details
  def get_driver_details
    @resource = Resource.find(params[:id])
    @driver = Driver.find(AgencyStore.find_by_resource_id(params[:id]).driver_id)
    
    render :layout => false
  end

  # Returning the resource once used
  def user_return_status
    @rtb = ResourceTransportationBooking.find(params[:id])
    @rtb.update_attribute(:resource_returned_from_user,true)
    render :layout => false
  end

  def download_attachments
    @message = ResourceTransportationBooking.find(params[:id])
    send_file @message.attachment.path
  end
  
end
