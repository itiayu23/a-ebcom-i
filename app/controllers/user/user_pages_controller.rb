class User::UserPagesController < ApplicationController

  def show
      @user = User.find(params[:id])
      
      
      
      if @user == current_user
        @picts = @user.picts.page(params[:page])
        @novels = @user.novels.page(params[:page])
      else
        @novels = @user.novels.where(privacy: "1").page(params[:page])
        @picts = @user.picts.where(privacy: "1").page(params[:page])
      end
     
    # DM用コントローラー
    # ゲストユーザーがユーザーページを見れるようにする
     if user_signed_in? && current_user != @user && current_user.following?(@user) && @user.following?(current_user) 
    @current_entry = Entry.where(user_id: current_user.id)
    @another_entry = Entry.where(user_id: @user.id)

      unless @user.id == current_user.id
        @current_entry.each do |current|
          @another_entry.each do |another|
            if current.room_id == another.room_id then
              @is_room = true
              @room_id = current.room_id
            end
          end
        end
        if @is_room
        else
          @room = Room.new
          @entry = Entry.new
        end
      end
     end
      # ここまでDM
  end

  def index
      @users = User.all

      @pict = Pict.find(params[:id])
      @novel = Novel.find(params[:id])
  end

  def edit
     is_matching_login_user
      @user = User.find(params[:id])
  end

  def update
    is_matching_login_user
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "プロフィールが更新されました"
      redirect_to user_page_path(@user.id)
    else
      render :edit
    end
  end

  def check
      @user = User.find(params[:id])
  end

  def withdraw
    @user = current_user
    @user.update(is_delete: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

private

def user_params
  params.require(:user).permit(:nickname, :profile_image, :name, :birthday, :profile, :contact, :twitter, :facebook, :instagram)
end

def is_matching_login_user
  user_id = params[:id].to_i
  unless user_id == current_user.id
    redirect_to root_path
  end

end

end
