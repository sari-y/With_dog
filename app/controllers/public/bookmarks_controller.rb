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

   def create_mini
    @review = Review.find(params[:review_id])
    current_user.bookmark(@review)
  end

  def destroy_mini
    @review = current_user.bookmarks.find_by(id: params[:id])&.review
    current_user.unbookmark(@review)
  end

  def index
    @bookmark_reviews = current_user.bookmark_reviews.page(params[:page]).per(9).includes(:user).order(created_at: :desc)
    if params[:latest]
      @bookmark_reviews = Review.page(params[:page]).per(9).latest
    elsif params[:old]
      @bookmark_reviews = Review.page(params[:page]).per(9).old
    elsif params[:rating_count]
      @bookmark_reviews = Review.page(params[:page]).per(9).rating_count
    else
      @bookmark_reviews = Review.page(params[:page]).per(9).order(created_at: :desc)
    end
  end

end
