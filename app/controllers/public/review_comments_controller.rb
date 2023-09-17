class Public::ReviewCommentsController < ApplicationController
  before_action :authenticate_user!


  def create
    @review = Review.find(params[:review_id])
    comment = current_user.review_comments.new(review_comment_params)
    comment.review_id = @review.id
    @review_comment = ReviewComment.new
    if comment.save
      flash[:success] = "コメントが投稿されました。"
    else
      flash[:error] = "コメントの投稿に失敗しました。"
    end
    redirect_to review_path(@review)
  end

  def destroy
    @review = Review.find(params[:review_id])
    comment = @review.review_comments.find(params[:id])
    @review_comment = ReviewComment.new
    if comment.destroy
      flash[:success] = "コメントが削除されました。"
    else
      flash[:error] = "コメントの削除に失敗しました。"
    end
    redirect_to review_path(@review)
  end


  private

  def review_comment_params
    params.require(:review_comment).permit(:text)
  end


end





