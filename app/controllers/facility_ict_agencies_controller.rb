class FacilityIctAgenciesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_admin

  def index
    if params[:id].blank? || params[:id].nil?
      @facility_ict_agency = FacilityIctAgency.page(params[:page]).per(10).order('created_at DESC')
    end
  end

  def create
    @facility_ict_agency = FacilityIctAgency.create(params[:facility_ict_agency])
    @facility_ict_agency.save
    if @facility_ict_agency.valid?
      redirect_to :controller=>'facility_ict_agencies', :action=>'index'
    else
      render :action=>'new'
    end
  end

  def new
    @facility_ict_agency = FacilityIctAgency.new()
  end

  def show
  end

  def edit
    @facility_ict_agency = FacilityIctAgency.find(params[:id])
  end

  def update
    @facility_ict_agency = FacilityIctAgency.find(params[:id]) if params[:id]
    if @facility_ict_agency.update_attributes(params[:facility_ict_agency])
      redirect_to(facility_ict_agencies_path, :notice => 'Agency has been successfully updated.')
    else
      render :action=>'new'
    end
  end

  def update_status
    @facility_ict_agency = FacilityIctAgency.find(params[:id])
    if params[:status]=="Activate"
      @facility_ict_agency.update_attribute(:is_active,true)
    elsif params[:status]=="Deactivate"
      @facility_ict_agency.update_attribute(:is_active,false)
    end
    redirect_to( facility_ict_agencies_path, :notice => 'Facility ICT Agency Status has been successfully changed.')
  end
  
  def destroy
  end

end
