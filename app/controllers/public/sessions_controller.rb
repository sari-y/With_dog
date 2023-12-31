# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def after_sign_in_path_for(resource)
    flash[:notice] = "ログインが正常に行われました。"
    users_my_page_path(current_user)
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to users_my_page_path(user), notice: "guestuserでログインしました。"
  end

  def destroy
    sign_out(current_user)
    redirect_to root_path, notice: "ログアウトが正常に行われました。"
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
