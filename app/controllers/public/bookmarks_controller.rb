class Public::BookmarksController < ApplicationController
   before_action :authenticate_user!

  def create
    @review = Review.find(params[:review_id])
    current_user.bookmark(@review)
  end

  def destroy
    @review = current_user.bookmarks.find_by(id: params[:id])&.review
    current_user.unbookmark(@review)
  end

  def index
    @bookmark_reviews = current_user.bookmark_reviews.includes(:user).order(created_at: :desc)
  end

end
