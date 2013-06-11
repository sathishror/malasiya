class DriversController < ApplicationController
  before_filter :authenticate_user!

  def index
    @drivers = Driver.all
  end

  def new
    @driver = Driver.new
  end

  def show
    @driver = Driver.find(params[:id])
  end

  def create
    @driver = Driver.new(params[:driver])
    if @driver.valid?
      @driver.save
      redirect_to drivers_path
    else
      render :action => 'new'
    end
  end

  def edit
    @driver = Driver.find(params[:id])
  end

  def update
    @driver = Driver.find(params[:id]) if params[:id]
    if @driver.update_attributes(params[:driver])
      redirect_to(drivers_path, :notice => 'Driver has been successfully updated.')
    else
      render :action=>'new'
    end
  end

  def update_status
    driver = Driver.find(params[:id])
    if params[:status]=="Activate"
      driver.update_attribute(:is_active,true)
    elsif params[:status]=="Deactivate"
      driver.update_attribute(:is_active,false)
    end    
    redirect_to(drivers_path, :notice => 'Driver Status has been successfully changed.')
  end

end
