class DepartmentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_admin#, :except=>'depart_user_list'

  #List all Department
    def index
      @departments=nil
    agencyid = params[:agency_id].to_i # while selecting Please Select returns string params
    if agencyid == 0
      @departments = Department.all_undeleted.page(params[:page]).per(10)
      #@departments = departments.page(params[:page]).per(10)
    else
      agency = Agency.find_by_id(params[:agency_id])
      @departments = agency.departments.all_undeleted.page(params[:page]).per(10)
    end
    if request.xhr?
      render :layout=>false
    end
  end

  #new Department
  def new
    @department = Department.new
  end

  #Create a new Department
  def create
    @department = Department.new(params[:department].merge!(:created_by => current_user.id))
    @department.save
    if @department.valid?
      redirect_to(departments_path, :notice => 'Department has been successfully created.')
    else
      render :action=>'new'
    end
  end

  #Edit an Department
  def edit
    @department = Department.find(params[:id])
  end

  #update a Department
  def update
    @department = Department.find(params[:id]) if params[:id]
    if @department.update_attributes(params[:department])
      redirect_to(departments_path, :notice => 'Department has been successfully updated.')
    else
      render :action=>'new'
    end
  end

  #Delete a Department
  def destroy
    @department = Department.find(params[:id])
    @department.deleted = true
    if @department.save
      redirect_to(departments_path, :notice => 'Department has been successfully deleted.')
    end
  end
  
  #Activate or Deactivate a particular Department
  def update_status
    department = Department.find(params[:id])
    if department && params[:status]=="Activate"
      department.update_attribute(:is_active,1)
    elsif department && params[:status]=="Deactivate"
      department.update_attribute(:is_active,0)
    end
    redirect_to(departments_path, :notice => 'Department Status has been successfully changed.')
  end

  def depart_list
    role = Role.where(:name => "Department Admin").first# || Role.new
    @users = role.users
  end
  
  def depart_user_list
    admin_departments=current_user.departments.collect(&:id)
    @users=User.joins(:departments, :roles).where("role_memberships.department_id in (?) and roles.name in (?)", admin_departments,DISP_USER_ROLE_DEPT_USER)
  end

  #Activate or Deactivate a particular User
  def update_user_status
    @user = User.find(params[:id])
    if params[:status]=="Activate"
      @user.update_attribute(:status,"Active")
    elsif params[:status]=="Deactivate"
      @user.update_attribute(:status,"Deactive")
    end
    department_id= !params[:department_id].blank? || !params[:department_id].nil? ?  params[:department_id] : nil
    redirect_to(depart_list_departments_path(:department_id=>department_id), :notice => 'User Status has been successfully changed.')
  end
end
