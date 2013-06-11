class FacilityIctHardwaresController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_admin

  def index
    if params[:id].blank? || params[:id].nil?
      @facility_ict_hardware = FacilityIctHardware.order.page(params[:page]).per(10)
    end
  end

  def create
    @facility_ict_hardware = FacilityIctHardware.create(params[:facility_ict_hardware])
    @facility_ict_hardware.save
    if @facility_ict_hardware.valid?
      redirect_to :controller=>'facility_ict_hardwares', :action=>'index'
    else
      render :action=>'new'
    end
  end

  def new
    @facility_ict_hardware = FacilityIctHardware.new()
  end

  def show
  end

  def edit
    @facility_ict_hardware = FacilityIctHardware.find(params[:id])
  end

  def update
    @facility_ict_hardware = FacilityIctHardware.find(params[:id]) if params[:id]
    if @facility_ict_hardware.update_attributes(params[:facility_ict_hardware])
      redirect_to(facility_ict_hardwares_path, :notice => 'Hardware has been successfully updated.')
    else
      render :action=>'new'
    end
  end

  def update_status
    @facility_ict_hardware = FacilityIctHardware.find(params[:id])
    if params[:status]=="Activate"
      @facility_ict_hardware.update_attribute(:is_active,true)
    elsif params[:status]=="Deactivate"
      @facility_ict_hardware.update_attribute(:is_active,false)
    end
    redirect_to( facility_ict_hardwares_path, :notice => 'Facility ICT Hardware Status has been successfully changed.')
  end

  def destroy
  end
end
