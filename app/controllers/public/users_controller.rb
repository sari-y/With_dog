class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.page(params[:page]).per(5).order(created_at: :desc)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    flash[:notice] = "登録情報を更新しました。"
    redirect_to  users_my_page_path(current_user)
  end

  def confirm_withdraw

  end

  def withdraw
    @user = current_user
    @user.update
    reset_session
    flash[:notice] = "退会処理が完了しました。ご利用いただきありがとうございました。"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :dog_name, :dog_breed, :dog_age)
  end

  def ensure_guest_user
    @user = current_user
    if @user.guest_user?
      redirect_to users_my_page_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end
