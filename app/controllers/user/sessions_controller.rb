# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

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

  protected
  
  def reject_user
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.is_delete == false)
        flash[:alert] = "退会済みです。またご活用される場合は再度ご登録の方をお願いします"
        redirect_to new_user_session_path
      else
        flash[:notice] = "項目を入力してください"
        
      end
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
