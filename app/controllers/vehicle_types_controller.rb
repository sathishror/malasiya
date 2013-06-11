class VehicleTypesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @vehicle_types = VehicleType.all
  end

  def new
    @vehicle_type = VehicleType.new
  end

  def create
    @vehicle_type = VehicleType.new(params[:vehicle_type])
    if @vehicle_type.valid?
      @vehicle_type.save
      redirect_to vehicle_types_path
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def show
  end

end
