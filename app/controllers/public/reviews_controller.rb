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
  end

  def show
  end

  def edit
  end


  private

  def review_params
    params.require(:review).permit(:facility_name, :text, :post_code, :address, :image)
  end

end