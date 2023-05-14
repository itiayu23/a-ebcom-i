class User::RelationshipsController < ApplicationController
     # フォローするとき
  def create
    current_user.follow(params[:user_page_id])
    @user = User.find(params[:user_page_id])
     # 通知の作成
    @user.create_notification_follow!(current_user)
    redirect_to request.referer
  end


  # フォロー外すとき
  def destroy
    current_user.unfollow(params[:user_page_id])
    redirect_to request.referer
  end


  # フォロー一覧
  def followings
    user = User.find(params[:user_page_id])
    @users = user.followings
  end


  # フォロワー一覧
  def followers
    user = User.find(params[:user_page_id])
    @users = user.followers
  end
end
