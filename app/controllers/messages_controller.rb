class MessagesController < ApplicationController
  require 'stalker'
  include MessagesHelper
  before_filter :authenticate_user!
  #Listing out the Messages of logged-in user
  def index
    collect_messages
    @message = Message.new
    #Stalker.enqueue('email.send', :to => 'joe@example.com')
  end

  #Creating a New Message Instance
  def new
    @message = Message.new
  end

  #Creating a New Message
  def create
    message = Message.new(params[:message])
    if message.valid?
      create_messages(params[:message_user_select],message)
      message.attachment = params[:file] if params[:file]       
      redirect_to messages_path
    else
      render :action => 'index'
    end
  end

  #For Auto-complete action
  def autocomplete_user_icnumber
    @users = User.find(:all,:conditions=>["id != ? and first_name like ?",current_user.id,"%#{params[:term]}%"])
    
    a=[]
    for user in @users
      h = {"label"=>user.first_name,"id"=> user.id,"value"=>user.first_name}
      a << h
    end
    render :json => a
  end

  # For Retrieving Agency List
  def get_agencies
    @type = params[:value]
    agencies= Agency.where(:deleted => false)
    render :layout => false    
  end

  # For Retrieving Department List
  def get_departments
    @type = params[:value]    
    render :layout => false   
  end

  # For Retrieving Unit List
  def get_units
    @agency, @depts = params[:agency], params[:dept]
    render :layout => false
  end

  # For Retrieving Particular Department Admin
  def get_department_admin
    @agency,@dept = Agency.find(params[:agency]), Department.find(params[:dept])      
    role = @dept.role_memberships.where(:role_id=>2)
    @dept_admin = User.find(role[0].user_id) if !role.blank?
    render :layout => false
  end

  # For Retrieving Particular Unit Admin
  def get_unit_admin
    @agency, @depts, @unit = params[:agency], params[:dept], Unit.find(params[:unit])
    role = @unit.role_memberships.where(:role_id=>4)
    @unit_admin = User.find(role[0].user_id) if !role.blank?    
    render :layout => false
  end

  #Posting Messages
  def post_messages

    message = Message.create(:message=>params[:message],:sender=>current_user.id)

    if params[:dept] && params[:dept]!= ""
      message.message_type, message.agency_id, message.department_id, message.sent_to_all_dept_admins = "Department", 0 , params[:dept], false
    elsif params[:agency] && params[:agency]!= ""
      message.message_type, message.agency_id, message.department_id, message.sent_to_all_dept_admins = "Agency", params[:agency], 0, false
    elsif params[:all_admins] && params[:all_admins]!= ""
      message.message_type, message.agency_id, message.department_id, message.sent_to_all_dept_admins = "AllDeptAdmin", 0, 0, true
    elsif params[:dept_admin] && params[:dept_admin]!= ""
      message.message_type, message.agency_id, message.department_id, message.sent_to_all_dept_admins = "DeptAdmin", 0, params[:department], true
    else
      message.message_type, message.agency_id, message.department_id, message.sent_to_all_dept_admins = "Superadmin", 0, 0, false
    end
    
    message.save
    collect_messages

    render :layout => false
  end

  #Posting Comments
  def post_comments
    @message = Message.find(params[:id])
    ms = MessageComment.create(:message_id=>params[:id],:comments=> params[:msg], :commenter_id => current_user.id)    
    render :layout => false
  end

  #Deleting Messages
  def destroy
    @message = Message.find(params[:id]).update_attribute(:deleted,true)    
    redirect_to messages_path
  end
  
end
