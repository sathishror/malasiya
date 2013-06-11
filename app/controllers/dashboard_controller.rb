class DashboardController < ApplicationController
  include MessagesHelper
  before_filter :authenticate_user!,:except=>[:set_locale]
  #  layout 'main_content'
  def index
    if current_user.is_super_admin?
      @users = Role.where(:name => "Department Admin").first.users
      #elsif current_user.is_department_admin? || current_user.is_department_user? || current_user.is_unit_admin? # UnitAdmin And Resource Manager Not Included
    elsif current_user.is_department_admin? || current_user.is_department_user?
      current_department
      department = current_user.departments.first
      @users = Department.find(department).users 
    end
    collect_messages    
  end

  def change_default_department
    department=Department.find(params[:department_id]) if params[:department_id]
    if department && department!=nil
      session[:department_id]=department.id
      current_department
      #      role=current_user.role_memberships.where(:default_dept => true)
      #      role.first.update_attribute(:default_dept, false)
      new_role=current_user.role_memberships.where(:department_id=>department.id)
      #      new_role.first.update_attribute(:default_dept, true)
      render :json=>["success",new_role.first.role.name]
    else
      render :json=>["error",new_role.first.role.name]
    end
  end


  #protected
  
  def set_locale
  if params[:locale]
      session[:locale]= params[:locale]
      p'hhhhhhhhhhhhhhhhhhhhhhhhh',params[:locale]
      I18n.locale = session[:locale]
    end
    redirect_to dashboard_index_path
  end
  
  
end
