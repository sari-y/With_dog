class Admin::ReviewsController < ApplicationController
  def index
  @reviews = Review.page(params[:page]).per(5)
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
