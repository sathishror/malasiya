class IctNetworkPointsController < ApplicationController

  def index
    @requisition = IctNetworkPoint.where(:user_id => current_user.id).order.page(params[:page]).per(4)
  end

  def new
    @requisition=IctNetworkPoint.new
  end

  def show
    @ict_network = IctNetworkPoint.find(params[:id])
    @type_name  = RequisitionType.find_by_id(@ict_network.requisition_type_id)
  end

  def create    
    requisition=IctNetworkPoint.create(params[:ict_network_point])
    requisition.requisition_type_id = params[:requisition_type_id]
    requisition.user_id = params[:user_id]
    requisition.department_id = params[:department_id]
    requisition.status = "New"
    requisition.save
    @approve = Approver.active.find_all_by_department_id(current_user.departments).first
    dept = Department.find_by_id(params[:department_id])
    if !@approve.present?
      user = dept.users.where("role_id = 2").first
      UserMailer.send_mail_to_dept_admin_for_ict_network(user,requisition,dept).deliver
    else
      user = User.find_by_id(@approve.user_id)
      UserMailer.send_mail_to_approver_for_ict_network(user,requisition,dept).deliver
    end
    if requisition.valid?
      redirect_to :controller=>'ict_network_points', :action=>'index'
    else
      render :action=>'new'
    end
  end

  def list_ict_network
    @approve = Approver.active.find_all_by_department_id(current_user.departments).first
    @approver_second = Approver.active.find_all_by_department_id(current_user.departments).last
    if !@approve.present? && !@approver_second.present?
      @list_network_point = IctNetworkPoint.where(:department_id => current_user.departments).order.page(params[:page]).per(4)
    else
      @list_network_point = IctNetworkPoint.where(:person_incharge => current_user.id).order.page(params[:page]).per(4)
    end
    if @approve.present?
      @list_network_point = IctNetworkPoint.where(:department_id => @approve.department_id).order.page(params[:page]).per(4)
      #    else @approver_second.present?
      #      @list_network_point = IctNetworkPoint.where(:department_id => @approver_second.department_id)
    end
  end

  def approval_network_point
    @ict_network = IctNetworkPoint.find(params[:id])
    @type_name  = RequisitionType.find_by_id(@ict_network.requisition_type_id)
  end

  def update_approval_network_point
    network = IctNetworkPoint.find_by_id(params[:id])
    network.update_attributes(params[:ict_network_point])
    user = User.find_by_id(network.person_incharge)
    ordered_user = User.find_by_id(network.user_id)
    UserMailer.send_status_mail_for_ict_network(user,ordered_user,network).deliver
    redirect_to(list_ict_network_ict_network_points_path, :notice => 'Your ICT Network Point Status has been successfully updated.')
  end

  def list_to_select_ict
    @ict_hardware_booking=IctHardwareBooking.new
    @ict_hardware_booked_user=@ict_hardware_booking.ict_hardware_booked_users.build
  end

  def selected_list_ict
  end
end
