class ResourceRoomBookingsController < ApplicationController
  before_filter :authenticate_user!
  #  before_filter :is_admin

  def index
    if current_user && current_user.is_super_admin?
      @resource_room_booking = ResourceRoomBooking.all
    elsif current_user && current_user.is_resource_manager?
      @resource_room_bookings = ResourceRoomBooking.find_all_by_status("Approved")
    else
      @resource_room_bookings = ResourceRoomBooking.where(:user_id => current_user.id).order.page(params[:page]).per(5)
    end
  end

  def new
    @resource_room_booking = ResourceRoomBooking.new()
    @booking = CategoriesDepartments.where(:category_id=> "6", :department_id=> current_user.departments.first.id)
  end

  def edit
    @resource_room_booking= ResourceRoomBooking.find(params[:id])
  end

  def show
    if !params[:id].nil?
      @resource_room_booking = ResourceRoomBooking.find(params[:id])
      @resource = SubCategory.find_by_id(@resource_room_booking.sub_category_id)
      @facility = Facility.active.find_all_by_resource_id(@resource_room_booking.resource_id)
      @details_resource = Resource.active.find_by_id(@resource_room_booking.resource_id)
      @user = User.find_by_id(@resource_room_booking.user_id)
      @dept = Department.find_by_id(default_department)
      @agencystore = AgencyStore.find_by_sub_category_id(@resource_room_booking.sub_category_id)
      if @agencystore.present?
        @agency= Agency.find_by_id(@agencystore.agency_id)
        @manager= User.find_by_id(@agency.user_id)
      end
    end
  end

  def create
    agency = AgencyStore.find_by_resource_id(params[:resource_room_booking][:resource_id])
    if !agency.nil?
      if agency.booked == false
        agency.update_attribute(:booked, true)
        resource_room_booking = ResourceRoomBooking.create(params[:resource_room_booking])
        resource_room_booking.agency_store_id = agency.id
        if current_user.is_super_admin? || current_user.is_department_admin?
          resource_room_booking.status = "Approved"
        else
          resource_room_booking.status = "New"
        end      
        resource_room_booking.user_id = params[:user_id]
        resource_room_booking.department_id = params[:department_id]
        resource_room_booking.save
        @approve = Approver.active.find_all_by_department_id(current_user.departments).first
        dept = Department.find_by_id(params[:department_id])
        if !@approve.present?
          user = dept.users.where("role_id = 2").first
          UserMailer.send_mail_to_dept_admin_for_room_booking(user,resource_room_booking,dept).deliver
        else
          user = User.find_by_id(@approve.user_id)
          UserMailer.send_mail_to_approver_for_room_booking(user,resource_room_booking,dept).deliver
        end
        redirect_to(resource_room_bookings_path, :notice => "Your Room booking has been created sucessfully.")
      else
        redirect_to(new_resource_room_booking_path, :alert => "You cant book the Already Reserved Room, Please try other.")
      end
    else
      redirect_to(new_resource_room_booking_path, :alert => "Resource selected is not available in your Store, Are you want this as resource requistion.")
    end
  end

  def update
    @resource_room_booking = ResourceRoomBooking.find(params[:id]) if params[:id]
    if @resource_room_booking.update_attributes(params[:resource_room_booking])
      redirect_to(resource_room_bookings_path, :notice => 'Resource Room Booking has been successfully updated.')
    else
      render :action=>'new'
    end
  end

  def get_list_of_facility
    facilities = Facility.active.find_all_by_resource_id(params[:resource_id])
    render :json=>[facilities] if facilities
  end

  def list_resource_booking
    if current_user.is_resource_manager?
      @booking = ResourceRoomBooking.find_all_by_department_id(current_user.departments, :conditions => ["status != 'New'"])
    else
      @approve = Approver.active.find_all_by_department_id(current_user.departments).first
      @approver_second = Approver.active.find_all_by_department_id(current_user.departments).last
      if @approve.present?
        @booking = ResourceRoomBooking.find_all_by_department_id(@approve.department_id)
      elsif @approver_second.present?
        @booking = ResourceRoomBooking.where(:department_id => @approver_second.department_id)
      else
        @booking = ResourceRoomBooking.where(:department_id => current_user.departments).order.page(params[:page]).per(5)
      end
    end
  end

  def update_room_booking
    room = ResourceRoomBooking.find_by_id(params[:resource_book_id])
    agency_store = AgencyStore.find_by_resource_id(params[:resource_id])
    if params[:resource_room_booking][:status] == "Returned" ||  params[:resource_room_booking][:status] == "Declined"
      agency_store.update_attribute(:booked, false)
    end
    @resource_room_booking = ResourceRoomBooking.find_by_id(params[:resource_book_id])
    @resource_room_booking.update_attributes(params[:resource_room_booking])
    ordered_user = User.find_by_id(room.user_id)
    resource_manager = RoleMembership.find_by_department_id(room.department_id, :conditions=>["role_id = ?", 5])
    if resource_manager.present?
      user = User.find_by_id(resource_manager.user_id)
      UserMailer.send_status_mail_for_room_booking(user,ordered_user,room).deliver
    end
    redirect_to(list_resource_booking_resource_room_bookings_path, :notice => 'Your Room Booking Status has been successfully updated.')
  end

  def room_booking_approval
    if !params[:id].nil?
      @resource_room_booking = ResourceRoomBooking.find(params[:id])
      @resource = SubCategory.find_by_id(@resource_room_booking.sub_category_id)
      @facility = Facility.active.find_all_by_resource_id(@resource_room_booking.resource_id)
      @approve = Approver.find_by_department_id(current_user.departments)
      @details_resource = Resource.active.find_by_id(@resource_room_booking.resource_id)
      @user = User.find_by_id(@resource_room_booking.user_id)
      @dept = Department.find_by_id(current_department)
      @agencystore = AgencyStore.find_by_sub_category_id(@resource_room_booking.sub_category_id)
      if @agencystore.present?
        @agency= Agency.find_by_id(@agencystore.agency_id)
        @manager= User.find_by_id(@agency.user_id)
      end
    end
  end

  def user_return
    room = ResourceRoomBooking.find(params[:room_book_id])
    if params[:user_returned_status] == "true"
      room.update_attribute(:user_returned_status, true)
    else
      room.update_attribute(:user_returned_status, false)
    end
  end

  def get_resources
    if !params[:sub_category_id].nil?
      resoures = Resource.find_all_by_sub_category_id(params[:sub_category_id])
      #      resoures = Resource.find_all_by_sub_category_id(category.sub_category_id)
      render :json=>[resoures] if resoures
    end
  end

  def get_details_for_resource
    resources = Resource.find(params[:resource_id])
    render :json=>[resources] if resources
  end

end
