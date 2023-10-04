class Public::ReviewFavoritesController < ApplicationController
  before_action :authenticate_user!


  def create
    review = Review.find(params[:review_id])
    favorite = current_user.review_favorites.new(review_id: review.id)
    favorite.save
  end

  def destroy
    review = Review.find(params[:review_id])
    favorite = current_user.review_favorites.find_by(review_id: review.id)
    favorite.destroy
  end

end
