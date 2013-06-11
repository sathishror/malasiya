class UsersController < ApplicationController
  before_filter :authenticate_user!, :except=>[:activate]
  before_filter :is_admin, :except=>[:account_setting,:update_account_setting,:update_default_department, :user_profile, :emergency_reference, :declaration_property, :download_attachments, :show]
  
  #Activate or Deactivate a particular User
  def update_status
    @user = User.find(params[:id])
    if params[:status]=="Activate"
      @user.update_attribute(:status,"Active")
    elsif params[:status]=="Deactivate"
      @user.update_attribute(:status,"Deactive")
    end
    department_id= !params[:department_id].blank? || !params[:department_id].nil? ?  params[:department_id] : nil
    redirect_to(users_path(:department_id=>department_id), :notice => 'User Status has been successfully changed.')
  end

  def edit
    @user=User.find(params[:id])
  end
  
  #Destroy a particular User
  def destroy
    @user = User.find(params[:id])
    @user.deleted = true
    if @user.save
      redirect_to(users_path, :alert => 'User deleted successfully.')
    end
  end

  #List all Users
  def index
    @users=nil
    if !current_user.is_super_admin?
      department_id = params[:department_id].to_i
      if department_id != 0
        department = Department.find_by_id(params[:department_id])
        @users = department.users.joins(:roles).where("users.deleted = false and roles.name = 'Department user'").page(params[:page]).per(10).order('created_at DESC')
      else
        if !params[:unit_id].nil?
          @users = Unit.find_by_id(params[:unit_id]).users.where("role_id !=2").page(params[:page]).per(10).order('created_at DESC')
        else
          default_department ||= current_user.role_memberships.first.department_id
          @dept = Department.find_by_id(default_department)
          @users = @dept.users.where("role_id != 2").page(params[:page]).per(10) if @dept
        end
      end
    else
      department_id = params[:department_id].to_i
      if department_id != 0
        department = Department.find_by_id(params[:department_id])
        @users = department.users.joins(:roles).where("users.deleted = false and roles.name = 'Department user'").page(params[:page]).per(10).order('created_at DESC')
      else
        if !params[:unit_id].nil?
          @users = Unit.find_by_id(params[:unit_id]).users.where("role_id !=2").page(params[:page]).per(10).order('created_at DESC')
        else
          @users=User.joins(:roles).where("users.deleted = false and roles.name = 'Department user'").page(params[:page]).per(10).order('created_at DESC')
        end
        @department_id=params[:department_id]
      end
    end
    if request.xhr?
      render :layout=>false
    end
  end
  
  ## Transfer Department Function begins here
  def transfer
   if !params[:department_id].nil? || !params[:department_id].blank?
      users= Department.find_by_id(params[:department_id]).users.where("role_id !=2")
      render :json=>[users] if users
    end
    if !params[:unit_id].nil?
      users = Unit.find_by_id(params[:unit_id]).users.where("role_id !=2")
      render :json=>[users] if users
    end
  end

  def get_dept_for_users
    user = User.find_by_ic_number(params[:ic_number])
    departments=user.departments.active.collect(&:name)
    render :json=>[departments] if departments
  end

  def update_transfer
    if params[:transfer][:username] != "" && params[:from_department][:id] != "" && params[:to_department][:id]!= "" && params[:transfer_from_agency] != "" && params[:transfer_to_agency] != ""
      user = User.find_by_ic_number(params[:transfer][:username])
      departments = user.departments
      s = Department.find_by_id(params[:to_department][:id])
      if user.departments.include?(s)
        redirect_to(transfer_users_path, :alert => "You Cant transfer the User to Already exist department")
      else
        role = RoleMembership.find_by_user_id(user.id)
        role.update_attribute(:department_id, params[:to_department][:id])
        department = Department.find_by_id(params[:to_department][:id])
        #UserMailer.intimate_user(user,department).deliver
        redirect_to(users_path, :notice => "#{user.first_name} has been transfer to #{department.name}.")
      end
    else
      redirect_to(transfer_users_path, :alert => "Please Select the Drop Box listed")
    end
  end

  ### Transfer Dept ends here
  def assign_department
    if !params[:department_id].nil? || !params[:department_id].blank?
      users= Department.find_by_id(params[:department_id]).users.where("role_id !=2")
      render :json=>[users] if users
    end
  end
  
  def update_assign
    if params[:transfer][:username] != "" && params[:from_department][:id] != "" && params[:to_department][:id]!= "" && params[:transfer_from_agency] != "" && params[:transfer_to_agency] != ""
      user = User.find_by_ic_number(params[:transfer][:username])
      departments = user.departments
      s = Department.find_by_id(params[:to_department][:id])
      if user.departments.include?(s)
        redirect_to(assign_department_users_path, :alert => "You cant Assign the User to Already exist department")
      else
        from_user =  User.find_by_ic_number(params[:transfer][:username])
        role = RoleMembership.new(:department_id => params[:to_department][:id], :user_id=> from_user.id, :role_id => '3', :status => 'A')
        role.save
        department = Department.find_by_id(params[:to_department][:id])
        #UserMailer.intimate_user_assign(user,department).deliver
        redirect_to(users_path, :notice => "#{user.first_name} has been assigned to #{department.name}. ")
      end
    else
      redirect_to(assign_department_users_path, :alert => "Please Select the Drop box listed")
    end

  end
  
  ## Transfer Unit Function begins here

  def transfer_unit
    if !params[:ic_number].nil?
      user = User.find_by_ic_number(params[:ic_number])
      departments = user.units.active.collect(&:name)
      render :json=>[departments] if departments
    end
  end

  def transfer_update_unit
    if params[:transfer_unit][:username] != "" && params[:from_department][:id] != "" && params[:to_department][:id]!= "" && params[:transfer_from_agency] != "" && params[:transfer_to_agency] != "" && params[:to_unit][:id] != "" && params[:users][:unit] != ""
      if params[:from_department][:id] == params[:to_department][:id] && params[:transfer_from_agency] == params[:transfer_to_agency]
        user = User.find_by_ic_number(params[:transfer_unit][:username])
        units = user.units
        s = Unit.find_by_id(params[:to_unit][:id])
        if user.units.include?(s)
          redirect_to(transfer_unit_users_path, :alert => "You Cant transfer the User to Already exist Unit")
        else
          role = RoleMembership.find_by_user_id(user.id)
          role.update_attributes(:unit_id => params[:to_unit][:id])
          unit = Unit.find_by_id(params[:to_unit][:id])
          #UserMailer.intimate_user(user,department).deliver
          redirect_to(users_path, :notice => "#{user.first_name} has been transfer to #{unit.name}.")
        end
      else
        redirect_to(transfer_unit_users_path, :alert => "Transfer across the Department has been restricted")
      end
    else
      redirect_to(transfer_unit_users_path, :alert => "Please Select the Drop Box listed")
    end
  end
  ## Transfer Unit Function ends here


  ## Assign Unit Starts here
  def assign_unit    
    if !params[:ic_number].nil?
      @val = params[:transfer_from][:agency]
      user = User.find_by_ic_number(params[:ic_number])
      departments = user.units.active.collect(&:name)
      render :json=>[departments] if departments
    end
  end

  def assign_update_unit
    p params[:transfer_from][:agency]
    @val = params[:transfer_from][:agency]
    if params[:transfer_unit][:username] != "" && params[:from_department][:id] != "" && params[:to_department][:id]!= "" && params[:transfer_from][:agency] != "" && params[:transfer_to][:agency] != "" && params[:to_unit][:id] != "" && params[:users][:unit] != ""
      if params[:from_department][:id] == params[:to_department][:id] && params[:transfer_from][:agency] == params[:transfer_to][:agency]
        user = User.find_by_ic_number(params[:transfer_unit][:username])
        units = user.units
        s = Unit.find_by_id(params[:to_unit][:id])
        if user.units.include?(s)
          redirect_to(assign_unit_users_path, :alert => "You cant Assign the User to Already exist department")
        else
          from_user =  User.find_by_ic_number(params[:transfer_unit][:username])
          role = RoleMembership.new(:department_id => params[:to_department][:id], :user_id=> from_user.id, :role_id => '3', :unit_id => params[:to_unit][:id],:status => 'A')
          role.save
          unit = Unit.find_by_id(params[:to_unit][:id])
          #UserMailer.intimate_user_assign(user,department).deliver
          redirect_to(users_path, :notice => "#{user.first_name} has been assigned to #{unit.name}. ")
        end
      else
        redirect_to(assign_unit_users_path, :alert => "Assign across the Department has been restricted")
      end
    else
      redirect_to(assign_unit_users_path, :alert => "Please Select the Drop box listed")
    end
  end
  ## Assign Unit Ends here

  def activate
    current_user = params[:activation_code].blank? ? false : User.find_by_activation_code(params[:activation_code])
    if current_user && !user_signed_in? && !current_user.account_active?
      current_user.activate
      #      current_user.save_ip(request.remote_ip)
      redirect_to new_user_session_path,:notice => "Congratulations! Your account has now been activated!"
    else
      redirect_to :root
    end
  end

  def admin_activation
    @users=User.joins(:roles).where("roles.name='#{DISP_USER_ROLE_DEPT_ADMIN}'").page(params[:page]).per(10)
  end

  def user_activation
    departments=RoleMembership.joins(:role).where("roles.name='#{DISP_USER_ROLE_DEPT_ADMIN}' and user_id=#{current_user.id}").collect(&:department_id)
    @users=User.joins(:roles).where("roles.name='#{DISP_USER_ROLE_DEPT_USER}' and role_memberships.department_id in (?) ", departments).page(params[:page]).per(10)
  end

  def activate_department_admin
    user=User.find(params[:id]) if params[:id]
    if user
      user.activate_user
      UserMailer.activation_mail_to_department_admin(user).deliver
      redirect_to :action=>"admin_activation"
    end
  end
  
  def activate_department_user
    user=User.find(params[:id]) if params[:id]
    if user
      user.activate_user
      UserMailer.activation_mail_to_department_admin(user).deliver
      redirect_to :action=>"user_activation"
    end
  end
  
  def account_setting
    @user = User.find(current_user.id)
  end

  def update_account_setting
    user = User.find_by_id(params[:user_id])
    user.update_attributes(:profile_status => params[:user][:profile_status], :widget_one => params[:user][:widget_one], :widget_two => params[:user][:widget_two])
    redirect_to(users_path, :notice => "Your Account Settings Updated successfully")
  end

  def update_default_department
    department=Department.find(params[:default][:department_id]) if params[:default][:department_id]
    if department && department!=nil
      role=current_user.role_memberships.where(:default_dept => true)
      role.first.update_attribute(:default_dept, false) if role && !role.empty? && role.first
      new_role=current_user.role_memberships.where(:default_dept => false,:department_id=>department.id)
      new_role.first.update_attribute(:default_dept, true)  if new_role && !new_role.empty? && new_role.first
    end
    redirect_to(users_path, :notice => "Your Account Settings Updated successfully")
  end

  def admin
    department_id = params[:department_id].to_i
    if department_id != 0
      department = Department.find_by_id(params[:department_id])
      #@users = department.users.joins(:roles).where("users.deleted = false and roles.name= 'Department Admin' || roles.name ='Unit Admin'").page(params[:page]).per(10) # Issue when Postgres sql is Used - Mathew
      @users = User.where(:deleted=>false).page(params[:page]).per(10)
    else
      #@users = User.joins(:roles).where("users.deleted = false and roles.name ='Department Admin' || roles.name ='Unit Admin'").page(params[:page]).per(10) # Issue when Postgres sql is Used - Mathew
      @users = User.where(:deleted=>false).page(params[:page]).per(10)
      @department_id=params[:department_id]
    end
    if request.xhr?
      render :layout=>false
    end
  end

  def online_users
    @users = User.find(:all, :conditions => ["username != ?", current_user.username])
  end
#Out station module
  def user_profile
    @users = User.find(current_user.id)
    if params[:commit] == 'Update Profile'
     @users.update_attributes(params[:user])
      if @users.valid?
      redirect_to :controller =>'user_services', :action => 'new'
      else
        render :action =>'user_profile'
      end
    end
  end
  
  def emergency_reference
    @emergency_references = EmergencyReference.find_by_user_id(current_user.id)
    if @emergency_references != nil
       @emergency_references.update_attributes(params[:emergency_reference])
    else
      @emergency_references = EmergencyReference.new(params[:emergency_reference])
    end
    if params[:commit] == 'Update Reference'
      if @emergency_references.valid?
    @emergency_references.save
    redirect_to :controller =>'users', :action=>'declaration_property'
      end
    end
  end

  def declaration_property
    @property_file = DeclarationProperty.new(params[:declaration_property])
    if params[:commit]
      @property_file.property_year = params[:date][:year]
      @property_file.user_id = current_user.id
      if @property_file.valid?
      @property_file.save
#      redirect_to :controller =>'outstations', :action=>'new'
      end
    end
  end
 def download_attachments
    @download = DeclarationProperty.find(params[:id])
    send_file @download.property_file.path
  end

def show
    @users = User.find(current_user.id)
    @service = UserService.find_by_user_id(current_user.id) 
    @service_level = ServiceLevel.find(@service.service_level_id)
    @classification = Classification.find(@service.classification_id)
    @standard = ServiceStandard.find(@service.service_standard_id)
    @appointment = Appointment.find(@service.appointment_id)
    @state = State.find(@service.state)
    #    @grade = Grade.find(@service.grade_id)
    @emergency_references = EmergencyReference.find_by_user_id(current_user.id)
    @declaration_properties = DeclarationProperty.find_by_user_id(current_user.id)
    @outstations = Outstation.find_by_user_id(current_user.id)

  end
 def show_stage
   @emergency_reference = EmergencyReference.find(current_user.id)
   @property_file = DeclarationProperty.find_all_by_user_id(current_user.id)
 end
# out station module methods ends here

end
