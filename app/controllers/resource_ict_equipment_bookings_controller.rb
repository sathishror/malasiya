class ResourceIctEquipmentBookingsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @resource_ict_equipment_bookings=ResourceIctEquipmentBooking.where(:user_id=>current_user.id).order.page(params[:page]).per(25)
  end
  
  def category
    @category=Category.get_category("ICT Equipment")
    @category_department = CategoriesDepartments.where(:category_id=>@category.first.id,:department_id=> @current_department) if @category and !@category.empty?
  end

  def new
    category
    @resource_ict_equipment_booking = ResourceIctEquipmentBooking.new
  end

  def create
    category
    dept = Department.find(@current_department)
    agency = AgencyStore.find(params[:resource_ict_equipment_booking][:agency_store_id]) if params[:resource_ict_equipment_booking] && !params[:resource_ict_equipment_booking][:agency_store_id].blank?
    if !agency.nil?
      if agency.booked == false
        @resource=params[:resource_ict_equipment_booking][:resource_id]
        @resource_ict_equipment_booking = ResourceIctEquipmentBooking.create(params[:resource_ict_equipment_booking].merge!({:department_id=>@current_department,:user_id=>current_user.id}))
        if @resource_ict_equipment_booking.valid?
          @resource_ict_equipment_booking.save
          @approve = Approver.active.find_all_by_department_id(@current_department).first
          if !@approve.present?
            user = dept.users.where("role_id = 2").first
            UserMailer.send_mail_to_dept_admin_for_ict_equipment_booking(user,@resource_ict_equipment_booking,dept).deliver
          else
            user = User.find(@approve.user_id)
            UserMailer.send_mail_to_approver_for_ict_equipment_booking(user,@resource_ict_equipment_booking,dept).deliver
          end
          agency.update_attribute(:booked, true)
          redirect_to resource_ict_equipment_bookings_path, :notice => "Your ICT Equipment booking has been created sucessfully."
        else
          render :action=>'new'
        end
      else
        redirect_to(new_resource_ict_equipment_booking_path, :alert => "You can't book already booked ICT Equipment, Please try other.")
      end
    else
      redirect_to(new_resource_ict_equipment_booking_path, :alert => "Resource selected is not available in your Store.")
    end
  end

#  def approval_details(ict_equipment)
#    @resource = SubCategory.find(ict_equipment.sub_category_id) if ict_equipment
#  end
  
  def show
    @resource_ict_equipment_booking = ResourceIctEquipmentBooking.find(params[:id]) if params[:id]
#    approval_details(@resource_ict_equipment_booking)
  end

  def requests
    if current_user.is_resource_manager?
      @booking = ResourceIctEquipmentBooking.find_all_by_department_id(@current_department, :conditions => ["status != 'New'"])
    else
      @approve = Approver.active.find_all_by_department_id(@current_department).first
      @approver_second = Approver.active.find_all_by_department_id(@current_department).last
      if @approve.present?
        @booking = ResourceIctEquipmentBooking.find_all_by_department_id(@approve.department_id)
      elsif @approver_second.present?
        @booking = ResourceIctEquipmentBooking.where(:department_id => @approver_second.department_id)
      else
        @booking = ResourceIctEquipmentBooking.where(:department_id => @current_department).order.page(params[:page]).per(25)
      end
    end
  end

  def approve_request
    @resource_ict_equipment_booking = ResourceIctEquipmentBooking.find(params[:id]) if params[:id]
#    approval_details(@resource_ict_equipment_booking)
  end
  
  def update_booking
    @resource_ict_equipment_booking = ResourceIctEquipmentBooking.find(params[:id])
    if @resource_ict_equipment_booking
      agency_store = @resource_ict_equipment_booking.agency_store
      agency_store.update_attribute(:booked, false) if (params[:resource_ict_equipment_booking][:status] == "Returned" ||  params[:resource_ict_equipment_booking][:status] == "Declined")
      status=params[:resource_ict_equipment_booking][:status].downcase
      params[:resource_ict_equipment_booking]["#{status}_date"]=Time.now
      if @resource_ict_equipment_booking.update_attributes(params[:resource_ict_equipment_booking].merge!({:approver_id=>current_user.id}))
        resource_manager = RoleMembership.find_by_department_id_and_role_id(@resource_ict_equipment_booking.department_id,5)
        #UserMailer.send_status_mail_for_ict_equipment_booking(resource_manager.user,@resource_ict_equipment_booking.user,@resource_ict_equipment_booking).deliver if resource_manager && resource_manager.user && !resource_manager.user.blank?
        UserMailer.send_status_mail_for_ict_equipment_booking(@resource_ict_equipment_booking.agency_store.agency.user,@resource_ict_equipment_booking.user,@resource_ict_equipment_booking).deliver if resource_manager && resource_manager.user && !resource_manager.user.blank?
        redirect_to(requests_resource_ict_equipment_bookings_path, :notice => 'Your ICT Equipment Status has been successfully updated.')
      else
        approval_details(@resource_ict_equipment_booking)
        render :action=>'approve_request', :id=>params[:id]
      end
    end
  end

  def user_return
    ict_equipment = ResourceIctEquipmentBooking.find(params[:ict_equipment_id])
    if params[:user_returned_status] == "true"
      if ict_equipment.update_attributes(:user_returned_status=> true, :returned_date=>Time.now)
        render :json=>["Success"]
      else
        render :json=>["Error"]
      end
    end
  end
end
