class TransferDepartmentController < ApplicationController
  def transfer_department
    #
    #    p "=========================="
    #    p params
    #    p "-------------------------"
if params[:standard]
    if params[:standard][:department_id]
      p (params[:standard][:department_id])
      @user = User.find_by_department_id(params[:standard][:department_id])
#      p "================params#{@user.inspect}"

      @user.update_attribute(:department_id, params[:department_id])
      flash[:notice] = "User has been transferred Successfully..."
      redirect_to :controller => 'users', :action => 'index'
    end
end

    if params[:username]!= nil && params[:username]!= ''
      @department_id=params[:department_id]
      @user.department_id
      @user.save
      @department.save
    end
    
    #@user = User.find(:all)
    if params[:department_id].blank? || params[:department_id].nil?
      @users=User.order.page(params[:page]).per(15).where("role_id !=1")
    else
      @users=User.order.page(params[:page]).per(15).where("role_id !=1 and department_id = ? ", params[:department_id])
      @department_id=params[:department_id]
    end
    
    if params[:status]=="Activate"
      @user.update_attribute(:status,"Active")
    elsif params[:status]=="Deactivate"
      @user.update_attribute(:status,"Deactive")
    end
    department_id= !params[:department_id].blank? || !params[:department_id].nil? ?  params[:department_id] : nil
    # redirect_to(users_path(:department_id=>department_id), :notice => 'User has been transferred successfully...')

  end
   
  def depart_list

    @user = User.find_by_department_id(params[:standard][:department_id])
    @user.update_attributes(params[:department_id])
  end

  def edit

  end
  def index
    render :layout=>false
  end
end
