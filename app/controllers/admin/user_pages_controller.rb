class Admin::UserPagesController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @users = User.all.page(params[:page]).per(5)
  end

  def show
    # @users = User.all
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "変更を保存しました"
    redirect_to admin_user_page_path(@user.id)
    else
    render :edit
    end
  end
  
  private
  
  def user_params
  params.require(:user).permit(:nickname, :profile_image, :name, :birthday, :profile, :contact, :twitter, :facebook, :instagram, :is_delete).merge({check: params[:user][:check].to_i})
  end
  
end
