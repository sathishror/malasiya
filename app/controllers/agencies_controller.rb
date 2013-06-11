class AgenciesController < ApplicationController
  before_filter :authenticate_user!
  def index
    @agencies=nil
    if params[:id].blank? || params[:id].nil?
      @agencies=Agency.where(:deleted => false).order.page(params[:page]).per(15)
    end
  end

  def new
    @agency = Agency.new
  end

  def edit
    @agency = Agency.find(params[:id])
  end

  def create
    @agency = Agency.create(params[:agency])
    @agency.save
    if @agency.valid?
      redirect_to :controller=>'agencies', :action=>'index'
    else
      render :action=>'new'
    end
  end

  def update
    @agency = Agency.find(params[:id]) if params[:id]
    if @agency.update_attributes(params[:agency])
      redirect_to(agencies_path, :notice => 'Agency has been successfully updated.')
    else
      render :action=>'new'
    end
  end

  def update_status
    agency = Agency.find(params[:id])
    if agency && params[:status]=="Activate"
      agency.update_attribute(:is_active,true)
    elsif agency && params[:status]=="Deactivate"
      agency.update_attribute(:is_active, false)
    end
    redirect_to(agencies_path, :notice => 'Agency Status has been successfully changed.')
  end

  def destroy
    @agency = Agency.find(params[:id])
    @agency.deleted = true
    if @agency.save
      redirect_to(agencies_path, :notice => 'Agency has been Deleted.')
    end
  end
# assign resource manager
def assign_resource_manager
    @agency = Agency.new
  end

  def update_assign_resource_manager
    from_user =  User.find_by_ic_number(params[:transfer][:username])
    agency = Agency.find_by_id(params[:transfer_from][:agency])
    role = RoleMembership.new(:department_id => 0, :user_id=> from_user.id, :role_id => '5', :status => 'A')
    agency.update_attribute(:user_id, from_user.id)
    role.save
    redirect_to(assign_resource_manager_agencies_path, :notice => 'Resource Manager has been Successfully Assigned.')
  end
# assign resource manager ends here
end
