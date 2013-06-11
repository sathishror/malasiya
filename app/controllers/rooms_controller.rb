class RoomsController < ApplicationController

  def index
    if params[:id].blank? || params[:id].nil?
      @room = Room.order.page(params[:page]).per(10)
    end
  end

  def new
    @room = Room.new()
  end

  def edit
    @room = Room.find(params[:id])
  end

  def create
    @room = Room.create(params[:room])
    if @room.valid?
      redirect_to(rooms_path, :notice => "Resource #{@room.name} has been created.")
    else
      render :action=>'new'
    end
  end

  def update
    @room = Room.find(params[:id]) if params[:id]
    if @room.update_attributes(params[:room])
      redirect_to(rooms_path, :notice => "Resource #{@room.name} has been updated.")
    else
      render :action=>'new'
    end
  end

   def update_status
    room = Room.find(params[:id])
    if room && params[:status]=="Activate"
      room.update_attribute(:is_active,true)
    elsif room && params[:status]=="Deactivate"
      room.update_attribute(:is_active,false)
    end
    redirect_to(rooms_path, :notice => "Facility for #{room.name} has been updated.")
  end
  
end
