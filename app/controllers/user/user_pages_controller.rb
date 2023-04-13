class User::UserPagesController < ApplicationController

  def show
      @user = User.find(params[:id])
      @picts = @user.picts
      @novels = @user.novels
      
    # DM用コントローラー
    # @current_entry = Entry.where(user_id: current_user.id)
    # @another_entry = Entry.where(user_id: @user.id)
     
    #   unless @user.id == current_user.id
    #     @current_entry.each do |current|
    #       @another_entry.each do |another|
    #         if current.room_id == another.room_id then
    #           @is_room = true
    #           @room_id = current.room_id
    #         end
    #       end
    #     end
    #     if @is_room
    #     else
    #       @room = Room.new
    #       @entry = Entry.new
    #     end
    #   end
      # ここまでDM
  end

  def index
      @users = User.all
      @pict = Pict.find(params[:id])
      @novel = Novel.find(params[:id])
  end

  def edit
      @user = User.find(params[:id])
  end
  
  def update
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
    redirect_to user_page_path(current_user.id)
  end

end






end
