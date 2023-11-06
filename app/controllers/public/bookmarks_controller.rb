class Public::BookmarksController < ApplicationController
   before_action :authenticate_user!

  def create
    @review = Review.find(params[:review_id])
    current_user.bookmark(@review)
    @list = params[:list]
  end

  def destroy
    @review = current_user.bookmarks.find_by(id: params[:id])&.review
    current_user.unbookmark(@review)
    @list = params[:list]
  end

  def index
    if params[:latest]
      @bookmark_reviews = current_user.bookmark_reviews.page(params[:page]).per(9).latest
    elsif params[:old]
      @bookmark_reviews = current_user.bookmark_reviews.page(params[:page]).per(9).old
    elsif params[:rating_count]
      @bookmark_reviews = current_user.bookmark_reviews.page(params[:page]).per(9).rating_count
    else
      @bookmark_reviews = current_user.bookmark_reviews.page(params[:page]).per(9).includes(:user).order(created_at: :desc)
    end
  end

end
