class Public::AttachmentsController < ApplicationController

  def destroy
    @review = Review.find(params[:id])
    @review.image.purge
    redirect_to review_path(@review)
  end

end
