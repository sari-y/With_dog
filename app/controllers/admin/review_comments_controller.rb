class Admin::ReviewCommentsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @review = Review.find(params[:review_id])
    comment = @review.review_comments.find(params[:id])
    @review_comment = ReviewComment.new
    if comment.destroy
      flash[:notice] = "コメントが削除されました。"
    else
      flash[:notice] = "コメントの削除に失敗しました。"
    end
    redirect_to admin_review_path(@review)
  end


  private

  def review_comment_params
    params.require(:review_comment).permit(:text)
  end

end
