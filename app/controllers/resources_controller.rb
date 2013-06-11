class ResourcesController < ApplicationController
  before_filter :authenticate_user!, :except=>[:activate]
  before_filter :is_admin, :except=>[:get_resources]
  def index
    department_id = params[:department_id].to_i # while selecting Please Select returns string params
    if department_id == 0
      if params[:id].blank? || params[:id].nil?
        if current_user.is_super_admin?
          @resources=Resource.page(params[:page]).per(10).order('created_at DESC')
        else
          @resources=Resource.where(:department_id=>current_department.id).page(params[:page]).per(1).order('created_at DESC')
        end
      else
        @resources=Resource.where(:sub_category_id=>params[:department_id]).page(params[:page]).per(1).order('created_at DESC')
      end
    else
      @resources=Resource.where(:sub_category_id=>params[:department_id]).page(params[:page]).per(1).order('created_at DESC')
    end
    if request.xhr?
      render :layout=>false
    end
  end
  def new
    @resource = Resource.new
  end

  def edit
    @resource = Resource.find(params[:id])
  end

  def create
    if params[:resource_type] == "room_booking"
      @resource = Resource.create(params[:resource])
      @resource.resource_type = params[:resource_type]
    elsif  params[:resource_type] =="transport"
      @resource = Resource.create(params[:resource])
      @resource.category_id = params[:resource_transport][:category_id]
      @resource.sub_category_id = params[:resource_transport][:sub_category_id]
      @resource.resource_type = params[:resource_type]
    elsif params[:resource_type] =="others"
      @resource = Resource.create(params[:resource])
      @resource.category_id = params[:resource_other][:category_id]
      @resource.sub_category_id = params[:resource_other][:sub_category_id]
      @resource.resource_type = params[:resource_type]
    elsif params[:resource_type]=="ict"
      @resource = Resource.create(params[:resource])
      @resource.sub_category_id = params[:resource_ict][:sub_category_id]
      @resource.resource_type = params[:resource_type]
    end
#    @resource.created_by = params[:created_by]
    if @resource.valid?
      @resource.save
      redirect_to :controller=>'resources', :action=>'index'
    else
      render :action=>'new'
    end
  end

  def update
    @resource = Resource.find(params[:id]) if params[:id]
    if @resource.update_attributes(params[:resource])
      redirect_to(resources_path, :notice => 'Resource has been successfully updated.')
    else
      render :action=>'new'
    end
  end

  def update_status
    category = Resource.find(params[:id])
    if category && params[:status]=="Activate"
      category.update_attribute(:is_active,true)
    elsif category && params[:status]=="Deactivate"
      category.update_attribute(:is_active, false)
    end
    redirect_to(resources_path, :notice => 'Resource status has been successfully changed.')
  end

  def destroy
    @resource = Resource.find(params[:id])
    @resource.deleted = true
    if @resource.save
      redirect_to(resources_path, :notice => 'Resource has been deleted.')
    end
  end

  def get_subcategory
    sub_categories= SubCategory.where("category_id =?",params[:agency_id])
    render :json=>[sub_categories] if sub_categories
  end

  def get_resources
    #resources=Resource.active_and_subcategory(params[:sub_category_id])
    resources=Resource.where("sub_category_id= ? and deleted=false", params[:sub_category_id])
    render :json=>[resources] if resources
  end

  def get_resource_type
    @resource = Resource.new    
    render :partial => 'form' , :department_id => 'room_booking'
  end

  def get_sub_category
    sub_categories= SubCategory.where("category_id =?",params[:sub_category_id])
    render :json=>[sub_categories] if sub_categories
  end

  def resource_approver
    @approve = Approver.new()
    @dept = Department.find(default_department)
    @users = @dept.users.page(params[:page]).per(10) if @dept
    fist_approver = Approver.active.find_all_by_department_id(current_user.departments).first
    if fist_approver.present?
      @first = User.find(fist_approver.user_id)
      second_approver = Approver.active.find_all_by_department_id(current_user.departments).last
      @second = User.find(second_approver.user_id)
    end
  end

  def list_approver
    if params[:id].blank? || params[:id].nil?
      if current_user.is_department_admin?
        @approve = Approver.active.find_all_by_department_id(current_user.departments)
      end
    end
  end

def update_resource_approver
    if params[:approver1][:id] != params[:approver2][:id]
      dept_admin = User.find_by_id(params[:admin_id])
      department = Department.find_by_id(params[:department_id])
      @val = Approver.find_all_by_department_id(params[:department_id]).first
      @second = Approver.find_all_by_department_id(params[:department_id]).last
      if @val.present? && @second.present?
        user = User.find_by_id(params[:approver1][:id])
        @val.update_attribute(:user_id, params[:approver1][:id])
        UserMailer.send_update_mail_to_approver1(user,dept_admin,department).deliver
        val = User.find_by_id(params[:approver2][:id])
        temp = User.find_by_ic_number(params[:approver2][:id])
        if val.present?
          @second.update_attribute(:user_id, val.id)
          UserMailer.send_update_mail_to_approver2(val,dept_admin,department).deliver
        elsif temp.present?
          @second.update_attribute(:user_id, temp.id)
          UserMailer.send_update_mail_to_approver2_temp(temp,dept_admin,department).deliver
        end
        redirect_to(list_approver_resources_path, :notice => 'Approver has been Updated.')
      else
        @approve = Approver.create(:is_active => params[:active1][:id])
        @approve.user_id = params[:approver1][:id]
        @approve.department_id = params[:department_id]
        @approve.save
        user = User.find_by_id(params[:approver1][:id])
        UserMailer.send_mail_to_approver1(user,dept_admin,department).deliver
        @approve = Approver.create(:is_active => params[:active2][:id])
        update = User.find_by_ic_number(params[:approver2][:id])
        if update.present?
          @approve.user_id = update.id
          @approve.department_id = params[:department_id]
          @approve.save
          user1 = User.find_by_id(update.id)
          UserMailer.send_mail_to_approver2(user1,dept_admin,department).deliver
          redirect_to(list_approver_resources_path, :notice => 'Approver has been Assigned.')
        end
      end
    else
      redirect_to(resource_approver_resources_path, :notice => 'You have Selected the Same User as 1st Approver and 2nd Approver')
    end
  end

  def get_approvers
    @dept = Department.find_by_id(default_department)
    users = @dept.users.where("user_id != #{params[:approver_id]}")
    
    render :json=>[users] if users
  end

end
