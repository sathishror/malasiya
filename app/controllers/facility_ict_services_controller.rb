class FacilityIctServicesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_admin

  def index
    if params[:id].blank? || params[:id].nil?
      @facility_ict_service = FacilityIctService.page(params[:page]).per(10).order('created_at DESC')
    end
  end

  def create
    @facility_ict_service = FacilityIctService.create(params[:facility_ict_service])
    @facility_ict_service.save
    if @facility_ict_service.valid?
      redirect_to :controller=>'facility_ict_services', :action=>'index'
    else
      render :action=>'new'
    end
  end

  def new
    @facility_ict_service = FacilityIctService.new()
  end

  def show
  end

  def edit
    @facility_ict_service = FacilityIctService.find(params[:id])
  end

  def update
    @facility_ict_service = FacilityIctService.find(params[:id]) if params[:id]
    if @facility_ict_service.update_attributes(params[:facility_ict_service])
      redirect_to(facility_ict_services_path, :notice => 'service has been successfully updated.')
    else
      render :action=>'new'
    end
  end

  def update_status
    @facility_ict_service = FacilityIctService.find(params[:id])
    if params[:status]=="Activate"
      @facility_ict_service.update_attribute(:is_active,true)
    elsif params[:status]=="Deactivate"
      @facility_ict_service.update_attribute(:is_active,false)
    end
    redirect_to( facility_ict_services_path, :notice => 'Facility ICT Service Status has been successfully changed.')
  end
  
  def destroy
  end
end
