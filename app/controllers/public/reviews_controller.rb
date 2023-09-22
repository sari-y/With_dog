
class Public::ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]


  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.new(review_params)
    if @review.save
      params[:review][:facility_category_ids].each do |id|
        ReviewFacilityCategory.create(review_id: @review.id, facility_category_id: id)
      end
      flash[:notice] = "新規投稿が正常に行われました。"
       redirect_to reviews_path
    else
      render :new
    end

  end

  def index
    if params[:facility_category_ids].present?
      @facility_categories = params[:facility_category_ids]
      @reviews = Review.includes(:review_facility_categories).where(review_facility_categories: {facility_category_id: @facility_categories})
    else
      @reviews = Review.all.order(created_at: :desc)
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


  private

  def review_params
    params.require(:review).permit(:facility_name, :text, :rating, :post_code, :address, :latitude, :longitude, image: [])
  end

end





