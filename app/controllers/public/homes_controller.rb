class Public::HomesController < ApplicationController
   before_action :authenticate_user!, except: [:top, :about]

  def top
     @reviews = Review.order('created_at DESC').limit(3)
  end

  def about
  end
end
