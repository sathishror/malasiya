class SubCategoriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_admin, :except=>[:get_sub_categories]
  
  def index
    if params[:id].blank? || params[:id].nil?
      if params[:category_id]
      @sub_categories=SubCategory.where("category_id=? and deleted=false",params[:category_id]).order.page(params[:page]).per(10)
      else
      @sub_categories=SubCategory.where(:deleted => false).order.page(params[:page]).per(10)
      end
    end
     if request.xhr?
      render :layout=>false
    end
  end

  def new
    @sub_category = SubCategory.new
  end

  def edit
    @sub_category = SubCategory.find(params[:id])
  end

  def create
    @sub_category = SubCategory.create(params[:sub_category])
    @sub_category.save
    if @sub_category.valid?
      redirect_to :controller=>'sub_categories', :action=>'index'
    else
      render :action=>'new'
    end
  end

  def update
    @sub_category = SubCategory.find(params[:id]) if params[:id]
    if @sub_category.update_attributes(params[:sub_category])
      redirect_to(sub_categories_path, :notice => 'Sub Category has been successfully updated.')
    else
      render :action=>'new'
    end
  end

  def update_status
    sub_category = SubCategory.find(params[:id])
    if sub_category && params[:status]=="Activate"
      sub_category.update_attribute(:is_active,true)
    elsif sub_category && params[:status]=="Deactivate"
      sub_category.update_attribute(:is_active, false)
    end
    redirect_to(sub_categories_path, :notice => 'Sub Category has been successfully changed.')
  end

  def destroy
    @sub_category = SubCategory.find(params[:id])
    @sub_category.deleted = true
    if @sub_category.save
      redirect_to(sub_categories_path, :notice => 'Sub Category has been Deleted.')
    end
  end

  def get_sub_categories
    sub_category=SubCategory.where("category_id=? and deleted=false",params[:category_id])
    render :json=>[sub_category]
  end
end
