class Admin::FacilityCategoriesController < ApplicationController
  def index
    @facility_categories = FacilityCategory.all
    @facility_category = FacilityCategory.new
  end
  
  def create
    @facility_category = FacilityCategory.new(facility_category_params)
    @facility_category.save
    redirect_to admin_facility_categories_path
  end
  
  def destroy
    @facility_category = FacilityCategory.find(params[:id])
    @facility_category.destroy
    flash[:facility_category_destroy] = "カテゴリーを削除しました。"
    redirect_to admin_facility_categories_path
  end
  
  private
  
  def facility_category_params
    params.require(:facility_category).permit(:category_name)
  end
  
end
