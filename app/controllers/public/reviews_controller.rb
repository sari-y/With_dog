
class Public::ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]


  def new
    @review = Review.new
    @user = current_user
  end

  def create
    @review = current_user.reviews.new(review_params)
    if @review.save
      params[:review][:facility_category_ids].each do |id|
        ReviewFacilityCategory.create(review_id: @review.id, facility_category_id: id)
      end
      flash[:notice] = "新規投稿が正常に行われました。"
       redirect_to review_path(@review)
    else
      render :new
    end

  end

  def index
    if params[:facility_category_ids].present?
      @facility_categories = params[:facility_category_ids]
      @reviews = Review.page(params[:page]).per(9).includes(:review_facility_categories).where(review_facility_categories: {facility_category_id: @facility_categories}).order(created_at: :desc)
    elsif params[:latest]
      @reviews = Review.page(params[:page]).per(9).latest
    elsif params[:old]
      @reviews = Review.page(params[:page]).per(9).old
    elsif params[:rating_count]
      @reviews = Review.page(params[:page]).per(9).rating_count
    else
      @reviews = Review.page(params[:page]).per(9).order(created_at: :desc)
    end
  end

  def show
    @review = Review.find(params[:id])
    @user = @review.user
    @review_comment = ReviewComment.new
  end

  def edit
    @review = Review.find(params[:id])
    @user = @review.user
    if @user == current_user
      render "edit"
    else
      redirect_to reviews_path
    end
  end


  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      @review.review_facility_categories.destroy_all
      params[:review][:facility_category_ids].each do |id|
      ReviewFacilityCategory.create(review_id: @review.id, facility_category_id: id)
      flash[:notice] = "レビューを更新しました。"
    end
      redirect_to review_path(@review)
    else
      flash[:notice] = "レビューの更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    if current_user == @review.user
      @review.destroy
      flash[:notice] = "レビューを削除しました。"
      redirect_to reviews_path
    else
      flash[:notice] = "削除に失敗しました。"
      redirect_to request.referer
    end
  end

  private

  def review_params
    params.require(:review).permit(:facility_name, :text, :rating, :post_code, :address, :latitude, :longitude, image: [])
  end

end





