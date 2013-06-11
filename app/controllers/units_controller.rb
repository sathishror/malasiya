class UnitsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_admin

  def index
    @units=nil
    if params[:department_id].blank? || params[:department_id].nil?
      @units=Unit.where(:deleted=> false).order.page(params[:page]).per(15)
    else
      @units=Unit.where(:deleted => false).order.page(params[:page]).per(15).where("department_id = ? ", params[:department_id])
      @department_id=params[:department_id]
    end
    if request.xhr?
      render :layout=>false
    end
  end

  def new
    @unit = Unit.new
  end

  def edit
    @unit = Unit.find(params[:id])
  end

  def create
    @unit = Unit.new(params[:unit])
    if @unit.save
      flash[:notice] = "Unit #{@unit.name} has been successfully created"
      department_id= !params[:unit][:department_id].blank? || !params[:unit][:department_id].nil? ?  params[:unit][:department_id] : nil
      redirect_to(units_path,:notice => "Unit #{@unit.name} has been successfully created.")
    else
      render :action => 'new'
    end
  end

  def update
    @unit = Unit.find(params[:id]) if params[:id]
    if @unit.update_attributes(params[:unit])
      department_id= !params[:department_id].blank? || !params[:department_id].nil? ?  params[:department_id] : nil
    redirect_to(units_path(:department_id=>department_id), :notice => 'Unit Status has been successfully changed.')
    else
      render :action=>'new'
    end
  end

  def update_status
    @unit = Unit.find(params[:id])
    if params[:status]=="Activate"
      @unit.update_attribute(:is_active,1)
    elsif params[:status]=="Deactivate"
      @unit.update_attribute(:is_active,0)
    end
    department_id= !params[:department_id].blank? || !params[:department_id].nil? ?  params[:department_id] : nil
    redirect_to(units_path(:department_id=>department_id), :notice => 'Unit Status has been successfully changed.')

  end

  def destroy
    @unit = Unit.find(params[:id])
    @unit.delete
    redirect_to(units_path, :notice => 'Unit has been Deleted.')
    if @unit.save
      department_id= !params[:department_id].blank? || !params[:department_id].nil? ?  params[:department_id] : nil
      redirect_to(units_path(:department_id=>department_id), :notice => 'Unit has been Deleted.')
    end
  end

end
