class User::NovelsController < ApplicationController
  def new
    @novel_new = Novel.new
  end
  
  def create
    # 下書きを後で追加する
    @novel_new = Novel.new(novel_params)
    @novel_new.user_id = current_user.id
    if @novel_new.save
      flash[:notice] = "小説が投稿されました"
      redirect_to user_novels_show(@novel_new.id)
    else
      @user = current_user
      @novels = @user.novels
      render :show
    end
      
  end

  def show
    @novel = Novel.find(params[:id])
    # 閲覧数を新しく作成し、小説ID、ユーザーをcurrent_user = つまり自分のIDを入力
    current_user.read_counts.create(novel_id: @novel.id)
    
  end

  def index
  end

  def edit
  end
end
