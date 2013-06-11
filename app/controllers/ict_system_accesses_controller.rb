class IctSystemAccessesController < ApplicationController
  before_filter :authenticate_user!
  def index
    if current_user && current_user.is_super_admin?
      @ict_system_access = IctSystemAccess.page(params[:page]).per(2)
    elsif current_user && current_user.is_department_admin?
      @ict_system_access = IctSystemAccess.page(params[:page]).per(2)
    else
      @ict_system_access = IctSystemAccess.where("user_id = ? or forward_to = ?", current_user.id, current_user.id).order.page(params[:page]).per(2)

    end

  end

  def new
    @ict_system_access=IctSystemAccess.new
  end

  def create
    @ict_system_access=IctSystemAccess.create(params[:ict_system_access])
    @ict_system_access.requisition_type_id = params[:requisition_type_id]
    @ict_system_access.user_id = current_user.id
    @ict_system_access.department_id = current_user.departments


    if @ict_system_access.valid?
      @ict_system_access.save

      @approve = Approver.active.find_all_by_department_id(current_user.departments).first
      dept = Department.find_by_id(current_user.departments)
      @requisition_ict_system_access=RequisitionType.find(@ict_system_access.requisition_type_id)
      @system_access_ict_system_access=SystemAccess.find(@ict_system_access.system_access_id)
      if !@approve.present?
        ict_email = dept.users.where("role_id = 2").first
        UserMailer.send_mail_to_ict_system_access(ict_email, @ict_system_access, @requisition_ict_system_access, @system_access_ict_system_access, current_user).deliver
      else
        ict_email = User.find_by_id(@approve.user_id)
        UserMailer.send_mail_to_ict_system_access(ict_email, @ict_system_access, @requisition_ict_system_access, @system_access_ict_system_access, current_user).deliver
      end



      redirect_to(ict_system_accesses_path, :notice => "Resource Requisition ICT System Access has been created.")
    else
      render :action=>'new'
    end
  end

  def update
    @ict_system_access=IctSystemAccess.find_by_id(params[:id])
    @requisition_ict_system_access=RequisitionType.find(@ict_system_access.requisition_type_id)
    @system_access_ict_system_access=SystemAccess.find(@ict_system_access.system_access_id)
    @ict_system_access.update_attributes(params[:ict_system_access])
      
    if @ict_system_access.update_attributes(params[:ict_system_access])
      ict_email = User.find_by_id(@ict_system_access.forward_to)
      UserMailer.send_mail_to_ict_system_access(ict_email, @ict_system_access, @requisition_ict_system_access, @system_access_ict_system_access, current_user).deliver

      redirect_to(ict_system_accesses_path, :notice => 'Booked Resource ICT System Access has been updated and Mail has been sent successfully')
    else
      render :action=>'new'
    end
  end


  def approval
    @ict_system_access=IctSystemAccess.find_by_id(params[:id])
    @requisition_ict_system_access=RequisitionType.find(@ict_system_access.requisition_type_id)
  end

  def show
    if !params[:id].nil?
      @ict_system_access=IctSystemAccess.find(params[:id])
    end
  end


  def download_attachments
    @ict_system_access = IctSystemAccess.find(params[:id])
    send_file @ict_system_access.system_access_attachment.path
  end

end
