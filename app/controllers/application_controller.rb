class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_department, :current_role

  #redirect user based on sign in count and force user to change password if logged in first time
  def home
    if user_signed_in?
      current_user.update_attribute(:login_status, true) if current_user # update login status for logged in user
      if !current_user.is_super_admin? && current_user.sign_in_count == 1 && current_user.created_by != 0 #User records which are created by super admin or dept admin has to change the password while they are logged in first time
        redirect_to :controller => "registrations", :action => "privacy_setting"
      else
        redirect_to :controller => "dashboard", :action => "index"
      end
    else
      redirect_to new_user_session_path
    end
  end
  
  #This method will keep the current_department object through out the application. If the user exist more than one department, then the selected department will be the current department object.
  #While the user first logged in, his default department will be the current department object. Hope this will works! but one thing we need to clear the session somewhere... #Manivannan
  def current_department
    if current_user && !current_user.is_super_admin?
      if !session[:department_id].nil?
        @current_department ||= session[:department_id]
      else
        @current_department ||= default_department
      end
    end
  end
  
  def current_role
    if current_user && (!current_user.is_super_admin?)
      department = Department.find(@current_department) if @current_department
      current_role_membership = RoleMembership.find_by_user_id_and_department_id(current_user.id,department.id) if department
      session[:current_role] = current_role_membership.role.name if current_role_membership
      return current_role_membership.role.name if current_role_membership
    elsif current_user && current_user.is_super_admin?
      current_user_role = Role.find_by_name(DISP_USER_ROLE_SUPER_ADMIN)
      session[:current_role] = current_user_role.name if current_user_role
      return current_user_role.name if current_user_role
    end
  end

  # this method is for restricting user from login before super admin approves him. Since it has to be needed some tweaks, i am commenting this for timebeing #manivannan
  #def validate_user_role_membership  
  # if (current_user.present? && current_department.present?)
  #rm = current_user.role_memberships.where(:department_id => current_department.id).first
  #if not rm.nil?
  # if rm.status == STATUS_INACTIVE
  #sign_out(current_user)
  #render :template => "errors/blocked.html.erb"
  #end
  #end
  #end
  #end    

  def is_admin
    if current_user && !((current_user.roles.first.name=="Super Admin" || current_user.roles.first.name=="Department Admin") && current_user.role_memberships.first.status=="A")
      redirect_to dashboard_index_path
    end
  end

  def is_resource_manager
    if current_user && !((current_user.roles.first.name=="Super Admin" || current_user.roles.first.name=="Resource Manager") && current_user.role_memberships.first.status=="A")
      redirect_to dashboard_index_path
    end
  end
  
  #This method will work if the user himself change his default department. For Future use #Manivannan
  def default_department
    default_department ||= current_user.role_memberships.where(:default_dept => true).first.department.id
  end

end
