class User::UserPagesController < ApplicationController
  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
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
      @novels = @user.novels
      @picts = @user.picts
  end

  def edit
    is_matcing_login_user
    @user = User.find(params[:id])
  end
  
  def update
    is_matcing_login_user
    
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "マイページが更新されました"
      redirect_to user_user_pages_show_path(@user_id)
    else
      render :edit
    end
  end

  def check
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :nickname, :profile_image, :profile, :birthday, :contact, :email, :is_status)
  end
  
  def is_matcing_login_user
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to user_user_pages_show_path(current_user.id)
    end
      
  end
  
end
