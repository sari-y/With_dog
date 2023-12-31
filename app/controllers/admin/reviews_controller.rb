class Admin::ReviewsController < ApplicationController
   before_action :authenticate_admin!

  def index
    @reviews = Review.page(params[:page]).order(created_at: :desc)
  end

  def show
    @review = Review.find(params[:id])
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice] = "レビューを削除しました。"
    redirect_to admin_reviews_path
  end


 private

  def review_params
    params.require(:review).permit(:facility_name, :text, :rating, :post_code, :address, image: [])
  end

end
