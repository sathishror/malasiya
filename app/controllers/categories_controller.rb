class CategoriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_admin

  def index
    if params[:id].blank? || params[:id].nil?
      if current_user.is_super_admin?
        @categories=Category.where(:deleted => false).order.page(params[:page]).per(10)
      else
        @categories=Category.order.page(params[:page]).per(10)
      end
    end
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.create(params[:category])
    @category.save
    if @category.valid?
      redirect_to :controller=>'categories', :action=>'index'
    else
      render :action=>'new'
    end
  end

  def update
    @category = Category.find(params[:id]) if params[:id]
    if @category.update_attributes(params[:category])
      redirect_to(categories_path, :notice => 'Resource Category has been successfully updated.')
    else
      render :action=>'new'
    end
  end

  def update_status
    category = Category.find(params[:id])
    if category && params[:status]=="Activate"
      category.update_attribute(:is_active,true)
    elsif category && params[:status]=="Deactivate"
      category.update_attribute(:is_active, false)
    end
    redirect_to(categories_path, :notice => 'Resource Category has been successfully changed.')
  end

  def destroy
    @category = Category.find(params[:id])
    @category.deleted = true
    if @category.save
      redirect_to(categories_path, :notice => 'Resource Category has been Deleted.')
    end
  end

  def assign_category
    @category = CategoriesDepartments.new
  end

  def update_category
    category = CategoriesDepartments.new
    category.department_id = params[:resource_category] [:department_id]
    category.category_id = params[:resource_category][:resource_category_id]
    cat_dept = CategoriesDepartments.where(:category_id => category.category_id, :department_id => category.department_id)
    if cat_dept == nil || cat_dept.blank?
       category.save
        redirect_to(list_category_mapping_categories_path, :notice => 'Resource Category has been sucessfully assigned  to Department.')
    else
        redirect_to(assign_category_categories_path, :alert => 'Resource Category has been already assigned to this Department.')
    end
  end

  def list_category_mapping
    if params[:category_id] != nil
     @department = params[:category_id].to_i
    else
    categories = Category.all
    categories.each do |category|
      @category_mapping = CategoriesDepartments.find_all_by_category_id(category.id)
      @category_mapping.each do |category|
        @categories = Category.find_all_by_id(category.category_id)
      end
    end
    end
     if request.xhr?
      render :layout=>false
    end
  end
  
def update_category_mapping
    category = CategoriesDepartments.find(params[:id])
    if category && params[:status]=="Activate"
      category.update_attribute(:is_active,true)
    elsif category && params[:status]=="Deactivate"
      category.update_attribute(:is_active, false)
    end
    redirect_to(list_category_mapping_categories_path, :notice => 'Map Category has been successfully changed.')
  end
end
