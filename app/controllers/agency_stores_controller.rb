class AgencyStoresController < ApplicationController
  before_filter :authenticate_user!, :except=>[:activate]
  before_filter :is_admin, :except=>[:get_resource_ict,:get_agency_resource,:get_other_resource_ict]

  def index
    @resource_id = params[:resource_id].to_i # while selecting Please Select returns string params
    if @resource_id == 0
      if params[:id].blank? || params[:id].nil?
        if current_user.is_super_admin?
          @stores=AgencyStore.order.page(params[:page]).per(10)
        else
          @stores=AgencyStore.where(:agency_id=>@resource_id).order.page(params[:page]).per(10)
        end
      end
    else
      if current_user.is_super_admin?
        @stores=AgencyStore.where(:agency_id=>@resource_id).order.page(params[:page]).per(10)
      end
    end
    if request.xhr?
      render :layout=>false
    end
  end

  def new
    @store = AgencyStore.new
  end

  def edit
    @store = AgencyStore.find(params[:id])
  end

  def create
    if params[:room_agency]
      @store = AgencyStore.create(params[:agency_store])
      @store.resource_type = params[:resource_type]
      @store.agency_id = params[:room][:agency_id]
      @store.sub_category_id = params[:room_agency][:sub_category_id]
      @store.resource_id = params[:room_agency][:resource_id]
      @store.save
    elsif params[:transport_agency]
      @store = AgencyStore.create(params[:agency_store])
      @store.resource_type = params[:resource_type]
      @store.agency_id = params[:transport][:agency_id]
      @store.driver_id = params[:transport][:driver_id]
      @store.sub_category_id = params[:transport_agency][:sub_category_id]
      @store.resource_id = params[:transport_agency][:resource_id]
      SubCategory.find(@store.sub_category_id).update_attribute(:is_available,true)
      @store.save
    elsif params[:ict_agency]
      @store = AgencyStore.create(params[:agency_store])
      @store.resource_type = "ICT"
      @store.agency_id = params[:ict][:agency_id]
      @store.sub_category_id = params[:ict_agency][:sub_category_id]
      @store.resource_id = params[:ict_agency][:resource_id]
      @store.save
    elsif params[:other_agency]
      
      #      quantity.times do
      @store = AgencyStore.create(params[:agency_store])
      quantity = params[:agency_store][:quantity].to_i
      @store.resource_type = params[:resource_type]
      @store.agency_id = params[:other][:agency_id]
      @store.category_id = params[:other_category][:id]
      @store.sub_category_id = params[:other_agency][:sub_category_id]
      @store.resource_id = params[:other_agency][:resource_id]
      if params[:dynamic]
        @store.serial_no =  params[:dynamic].values.join.to_s
        #        end
        
      end

    end

    #    store.categories_id = params[:categories_department][:id]
    #    store.sub_categories_id = params[:sub_categories][:id]
    #    if params[:dynamic]
    #    store.serial_no =  params[:text1] + params[:dynamic].to_s
    #    else
    #    store.serial_no =  params[:text1]
    #    end
    #    store.agency_id = params[:transfer_from][:agency]
    #    @store.save
    
    if @store.valid?
      @store.save
      SubCategory.find(@store.sub_category_id).update_attribute(:is_available,true) if params[:ict_agency]
      redirect_to :controller=>'agency_stores', :action=>'index'
    else
      render :action=>'new', :notice =>'Resource already added for this Sub category'
    end
  end

  def update
    @store = AgencyStore.find(params[:id]) if params[:id]
    if @store.update_attributes(params[:agency_store])
      redirect_to(agency_stores_path, :notice => 'Agency Store has been successfully updated.')
    else
      render :action=>'new'
    end
  end

  def update_status
    store = AgencyStore.find(params[:id])
    if store && params[:status]=="Activate"
      store.update_attribute(:is_active,true)
    elsif store && params[:status]=="Deactivate"
      store.update_attribute(:is_active, false)
    end
    redirect_to(agency_stores_path, :notice => 'Agency Store has been successfully changed.')
  end

  def destroy
    store = AgencyStore.find(params[:id])
    store.deleted = true
    if store.save
      redirect_to(agency_stores_path, :notice => 'Agency Store has been Deleted.')
    end
  end

  def get_resource
    resources = Resource.find_all_by_sub_category_id(params[:agency_id])
    render :json=>[resources] if resources
  end

  def get_categories
    dept = CategoriesDepartment.find_all_by_department_id(params[:agency_id])
    if dept == nil || dept.blank?
      @categories = nil
    else
      @categories = Category.find_all_by_id(dept[0].category_id)
    end
    render :json=>[ @categories] if  @categories
  end
  
  def get_sub_categories
    subcategories = SubCategory.find_all_by_id(params[:agency_id])
    render :json=>[ subcategories] if  subcategories
  end

  def get_vehicles
    vehicles = Vehicle.find_all_by_vehicle_type_id(params[:vehicle_id])
    render :json=>[ vehicles] if  vehicles
  end

  def get_resources
    agency_stores = AgencyStore.find_by_id(params[:resource_id])
    if agency_stores != nil
      sub_category = SubCategory.find_all_by_id(agency_stores.sub_category_id)
      render :json=>[ sub_category] if  sub_category
    else
      sub_category = 0
      render :json=>[ sub_category] if  sub_category
    end
  end

  def get_other_sub_categories
    subcategories = SubCategory.find_all_by_category_id(params[:agency_id])
    render :json=>[ subcategories] if  subcategories
  end

  def get_resource_ict
    if session[:current_role] == DISP_USER_ROLE_SUPER_ADMIN
      resources = Resource.where("sub_category_id = ? ", params[:sub_category_id])
      render :json=>[resources] if resources
    else
      department=Department.find(@current_department)
      resource = AgencyStore.where("booked = false and sub_category_id = ? and agency_id = ? ",params[:sub_category_id],department.agency_id).collect(&:resource_id)
      resources=[]
      if resource && !resource.empty?
        resources = Resource.find(resource)
      end
      render :json=>[resources.to_a] if resources
    end
    
    #    department=Department.find(@current_department)
    #    resource = AgencyStore.where("booked = false and sub_category_id = ? and agency_id = ? ",params[:sub_category_id],department.agency_id).collect(&:resource_id)
    #    resources=[]
    #    if resource && !resource.empty?
    #      resources = Resource.find(resource)
    #    end
    #    render :json=>[resources.to_a] if resources
    #p resources =Resource.active_and_subcategory(params[:sub_category_id])
  end

  def get_other_resource_ict
    department=Department.find(@current_department)
    resource = AgencyStore.where("booked = false and sub_category_id = ? and agency_id != ? ",params[:sub_category_id],department.agency_id).collect(&:resource_id)
    resources=[]
    if resource && !resource.empty?
      resources = Resource.find(resource)
    end
    render :json=>[resources.to_a] if resources
    #p resources =Resource.active_and_subcategory(params[:sub_category_id])
  end
  
  def get_agency_resource
    resources = AgencyStore.find_all_by_resource_id_and_booked(params[:resource_id],false)
    render :json=>[resources] if resources
  end

end
