class Admin::UsersController < ApplicationController

  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "会員情報を削除しました。"
    redirect_to admin_users_path
  end

private

  def user_params
    params.require(:user).permit(:name, :text, :image)
  end

end