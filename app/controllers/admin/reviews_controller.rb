class Admin::ReviewsController < ApplicationController
  before_action :authenticate_user!

  def index
  @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:review_destroy] = "会員情報を削除しました。"
    redirect_to admin_reviews_path
  end


 private

  def review_params
    params.require(:review).permit(:facility_name, :text, :rating, :post_code, :address, image: [])
  end

end
