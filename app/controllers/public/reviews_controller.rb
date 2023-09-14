
class Public::ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.new(review_params)
    if @review.save
      redirect_to reviews_path, notice: "新規投稿が正常に行われました。"
    else
      render :new
    end
  end

  def index
    @reviews = Review.all
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
      flash[:success] = "レビューを更新しました。"
      redirect_to review_path(@review)
    else
      flash[:error] = "レビューの更新に失敗しました。"
      render :edit
    end
  end


  private

  def review_params
    params.require(:review).permit(:facility_name, :text, :post_code, :address, image: [])
  end

end
