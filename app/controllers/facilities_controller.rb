class FacilitiesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_admin

  def index
    if params[:id].blank? || params[:id].nil?
      @facility = Facility.order.page(params[:page]).per(10)
    end
  end

  def new
    @facility = Facility.new()
  end

  def edit
    @facility = Facility.find(params[:id])
  end

  def create
    @facility = Facility.create(params[:facility])
    if params[:resource_type] == "room_booking"
      @facility.sub_category_id = params[:room][:sub_category_id]
      @facility.resource_id = params[:room][:resource_id]
      @facility.resource_type = params[:resource_type]
    elsif params[:resource_type] == "transport"
      @facility.sub_category_id = params[:transport][:sub_category_id]
      @facility.resource_id = params[:transport][:resource_id]
      @facility.resource_type = params[:resource_type]
    elsif params[:resource_type] == "others"
      @facility.sub_category_id = params[:other][:sub_category_id]
      @facility.resource_id = params[:other][:resource_id]
      @facility.resource_type = params[:resource_type]
    end
    @facility.save
    if @facility.valid?
      redirect_to(facilities_path, :notice => "Resource #{@facility.name} has been created.")
    else
      render :action=>'new'
    end
  end

  def update
    @facility = Facility.find(params[:id]) if params[:id]
    if @facility.update_attributes(params[:facility])
      redirect_to(facilities_path, :notice => "Resource #{@facility.name} has been updated.")
    else
      render :action=>'new'
    end
  end

  def update_status
    facility = Facility.find(params[:id])
    if facility && params[:status]=="Activate"
      facility.update_attribute(:is_active,true)
    elsif facility && params[:status]=="Deactivate"
      facility.update_attribute(:is_active,false)
    end
    redirect_to(rooms_path, :notice => "Facility for #{facility.name} has been updated.")
  end

end
