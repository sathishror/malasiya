class FacilityIctWiringsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_admin

  def index
    if params[:id].blank? || params[:id].nil?
      @facility_ict_wiring = FacilityIctWiring.page(params[:page]).per(10).order('created_at DESC')
    end
  end

  def create
    @facility_ict_wiring = FacilityIctWiring.create(params[:facility_ict_wiring])
    @facility_ict_wiring.save
    if @facility_ict_wiring.valid?
      redirect_to :controller=>'facility_ict_wirings', :action=>'index'
    else
      render :action=>'new'
    end
  end

  def new
    @facility_ict_wiring = FacilityIctWiring.new()
  end

  def show
  end

  def edit
    @facility_ict_wiring = FacilityIctWiring.find(params[:id])
  end

  def update
    @facility_ict_wiring = FacilityIctWiring.find(params[:id]) if params[:id]
    if @facility_ict_wiring.update_attributes(params[:facility_ict_wiring])
      redirect_to(facility_ict_wirings_path, :notice => 'Wiring has been successfully updated.')
    else
      render :action=>'new'
    end
  end

  def update_status
    @facility_ict_wiring = FacilityIctWiring.find(params[:id])
    if params[:status]=="Activate"
       @facility_ict_wiring.update_attribute(:is_active,true)
    elsif params[:status]=="Deactivate"
       @facility_ict_wiring.update_attribute(:is_active,false)
    end
    redirect_to( facility_ict_wirings_path, :notice => 'Facility ICT Wiring Status has been successfully changed.')
  end

  def destroy
  end

end
