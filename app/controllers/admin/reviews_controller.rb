class Admin::ReviewsController < ApplicationController
  def index
  @reviews = Review.all
  end

  def show
  end
end

 private

  def review_params
    params.require(:review).permit(:facility_name, :text, :rating, :post_code, :address, image: [])
  end
