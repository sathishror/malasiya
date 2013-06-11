class OutstationsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @outstations = Outstation.find_all_by_user_id(current_user.id)
  end

  def approve_request_for_state
    if current_user.is_department_user?
      @outstations = Outstation.find_all_by_user_id_and_is_out_of_state(current_user.id,true)
    elsif current_user.is_department_admin?
      @outstations = Outstation.where(:department_id=>current_user.departments,:is_out_of_state=>true)
    elsif current_user.is_human_resource_manager?
      @outstations = Outstation.find(:all,:conditions=>["status != 'New' and is_out_of_state = true"])
    elsif current_user.is_suk_deputy?
      users = RoleMembership.where(:role_id=>2).collect(&:user_id).compact.join(',')
      @outstations = Outstation.find(:all,:conditions=>["(((status = 'Recommended' or status = 'Approved') and is_out_of_state = true) or ((status='New' or status='Verified') and user_id in (#{users}) and is_out_of_state = true)) "])
    elsif current_user.is_chief_minister?
      users = RoleMembership.where(:role_id=>2).collect(&:user_id).compact.join(',')
      @outstations = Outstation.find(:all,:conditions=>["((status='Recommended' or status='Approved') and user_id in (#{users}) and is_out_of_state = true)"])
    end
  end

  def approve_request
    if current_user.is_department_user?
      @outstations = Outstation.find_all_by_user_id_and_is_out_of_state(current_user.id,false)
    elsif current_user.is_department_admin?
      @outstations = Outstation.where(:department_id=>current_user.departments,:is_out_of_state=>false)
    elsif current_user.is_human_resource_manager?
      @outstations = Outstation.find(:all,:conditions=>["status != 'New' and is_out_of_state = false"])
    elsif current_user.is_datuk_suk?
      users = RoleMembership.where(:role_id=>2).collect(&:user_id).compact.join(',')
      @outstations = Outstation.find(:all,:conditions=>["(((status = 'Recommended' or status = 'Approved') and is_out_of_state = false) or ((status='New' or status='Verified') and user_id in (#{users}) and is_out_of_state = false)) "])
    elsif current_user.is_chief_minister?
      users = RoleMembership.where(:role_id=>2).collect(&:user_id).compact.join(',')
      @outstations = Outstation.find(:all,:conditions=>["((status='Recommended' or status='Approved') and user_id in (#{users}) and is_out_of_state = false)"])
    end
  end


  def new
    @outstations = Outstation.new
  end

  def create
    @outstation = Outstation.new(params[:outstation])

    @outstation.is_out_of_state = (params[:outstation][:is_out_of_state] == 'Out of State' ? 1 : 0)
    @outstation.is_official = (params[:outstation][:is_official] == 'Official' ? 1 : 0)
    #@outstation.from_date = params[:outstation][:from_date].to_datetime
    #@outstation.to_date = params[:outstation][:to_date].to_datetime
    @outstation.department_id = current_user.role_memberships.where(:default_dept => true).first.department.id
    @outstation.status = 'New'

    if @outstation.valid?
      @outstation.save
      redirect_to outstations_path
    else
      render :action => 'new'
    end
  end

  def show
    @outstation = Outstation.find(params[:id])
  end

  def edit
    @outstation = Outstation.find(params[:id])
  end

  def update
    @outstation = Outstation.find(params[:id])
    case params[:status]
    when 'Verify'
      status = 'Verified'
    when 'Recommend'
      status = 'Recommended'
    when 'Approve'
      status = 'Approved'
    when 'Decline'
      status = 'Declined'
    end
    @outstation.update_attribute(:status,status)
    redirect_to(approve_request_outstations_path, :notice => 'Outstation Request has been successfully updated.')
  end

end
