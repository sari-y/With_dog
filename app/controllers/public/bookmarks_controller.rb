class Public::BookmarksController < ApplicationController
   before_action :authenticate_user!

  def create
    review = Review.find(params[:review_id])
    current_user.bookmark(review)
    flash[:success] = t('bookmark.create')
    redirect_back(fallback_location: root_path)
  end

  def destroy
    review = current_user.bookmarks.find_by(id: params[:id])&.review
    current_user.unbookmark(review)
    flash[:success] = t('bookmark.destroy')
    redirect_back(fallback_location: root_path)
  end

  def index
    @bookmark_reviews = current_user.bookmark_reviews.includes(:user).order(created_at: :desc)
  end

end
