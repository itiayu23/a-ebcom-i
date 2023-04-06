class User::NovelsController < ApplicationController
  # 自分以外の人が他人の小説を編集させないようにするコード
  before_action :ensure_novel, only:[:edit, :update, :destroy]
  
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
    @comment = Comment.new
    @user = @novel.user
    # 閲覧数を新しく作成し、小説ID、ユーザーをcurrent_user = つまり自分のIDを入力
    current_user.read_counts.create(novel_id: @novel.id)
    
  end

  def index
    if params[:latest]
      @novels = Novel.latest
    elsif params[:old]
      @novels = Novel.old
    else
      @novels = Novel.all
    end
  end

  def edit
    @novel = Novel.find(params[:id])
  end
  
  def update
    @novel = Novel.find(params[:id])
    if @novel.update(novel_params)
      flash[:notice] = "小説が更新されました"
      redirect_to user_novels_show_path(@novel.id)
    else
      render :edit
    end
  end
  
  def destroy
    novel = Novel.find(params[:id])
    novel.destroy
    redirect_to user_novels_show_path
  end

private

def novel_params
  params.require(:novel).permit(:title, :text_body, :image, :caption)
end

def ensure_novel
  @novels = current_user.novels
  @novel = @novels.find_by(id: params[:id])
  # 自分以外の小説の情報合致していないとunlessになる
  redirect_to user_novels_show_path unless @novel
  # unlessだった場合自分の小説一覧に飛ぶ
end

  
end
