class ConversationsController < ApplicationController
  def index
    if !params[:department_id].nil?
      department = Department.find_by_id(params[:department_id])
      @users = department.users.where("users.deleted = false ").page(params[:page]).per(10)
    else
      default_department ||= current_user.role_memberships.first.department_id
      @dept = Department.find_by_id(default_department)
      @users = @dept.users.where("users.deleted = false and username != ?", current_user.username).page(params[:page]).per(10) if @dept
    end
    if request.xhr?
      render :layout=>false
    end
  end

  def show
    if params[:id]
      @user=User.find(params[:id])
      if @user
        @conversations=Conversation.convos(params[:id],current_user.id)
      end
      if request.xhr?
        render :layout=>false
      end
    end
    @chat_conv=Conversation.convos(params[:id],current_user.id).order('created_at desc').limit(5)
    @users = User.find(:all, :conditions => ["username != ?", current_user.username])   
  end


  def create   
    @conversation = Conversation.create!(params[:conversation])
    @conversation.from_userid = current_user.id
    @conversation.save  
  end

  def list_users
    @users = User.all
  end
  def send_request
    emailchecking = User.find_by_email(params[:email])
    if emailchecking
      UserMailer.welcomemail_chat_user(emailchecking, current_user).deliver
      flash[:notice] = "Chat Request has been sent successfully"
      redirect_to :action => 'index'
    else
      flash[:error] = "Chat Request Failed"
      redirect_to :action => 'index'
    end
  end
  def get_users
    if !params[:department_id].nil?
      department = Department.find_by_id(params[:department_id])
      @users = department.users.joins(:roles).where("users.deleted = false and roles.name = 'Department user'").page(params[:page]).per(10)
    end
  end
end