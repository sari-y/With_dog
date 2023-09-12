class Public::UsersController < ApplicationController
  
  def show
    @user = current_user
    @reviews = @user.reviews 
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    flash[:update] = "登録情報を更新しました。"
    redirect_to  users_my_page_path
  end

  def confirm
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  
end
