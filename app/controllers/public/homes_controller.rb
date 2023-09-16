class Public::HomesController < ApplicationController
  def top
     @reviews = Review.order('created_at DESC').limit(3)
  end

  def about
  end
end
