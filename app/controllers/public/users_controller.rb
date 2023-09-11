class Public::UsersController < ApplicationController
  def show
    @user = current_user
    @reviews = @user.reviews 
  end

  def edit
  end

  def confirm
  end
end
