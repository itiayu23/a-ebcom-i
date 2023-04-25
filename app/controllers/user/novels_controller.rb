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
    
     tag_list = params[:novel][:tag_ids].split(',')
     
     
    if @novel_new.save
      @novel_new.save_tags(tag_list)
      flash[:notice] = "小説が投稿されました"
      redirect_to novel_path(@novel_new.id)
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
    if user_signed_in?
    current_user.read_counts.create(novel_id: @novel.id)
    end

  end

  def index
    @q = Tag.ransack(params[:q])
    if params[:latest]
      @novels = Novel.latest.where(privacy: "1").page(params[:page])
    elsif params[:old]
      @novels = Novel.old.where(privacy: "1").page(params[:page])
      
    elsif params[:q].present?
      
      @novels = Novel.where(id: WriteTag.where(tag_id: @q.result.order(created_at: :desc).pluck(:id)).pluck(:novel_id)).where(privacy: "1").page(params[:page]) || Novel.where(privacy: "1").page(params[:page])
      
    else
      @novels = Novel.where(privacy: "1").page(params[:page])
    end
  end

  def edit
    @novel = Novel.find(params[:id])
    @tag_list = @novel.tags.pluck(:name).join(",")
  end

  def update
    @novel = Novel.find(params[:id])
    @tag_list = params[:novel][:tag_ids].split(',')
    
    if @novel.update(novel_params)
      @novel.save_tags(@tag_list)
      flash[:notice] = "小説が更新されました"
      redirect_to novel_path(@novel.id)
    else
      render :edit
    end
  end

  def destroy
    novel = Novel.find(params[:id])
    novel.destroy
    # 自分のページのインデックスに飛ぶようにゆくゆくする
    redirect_to novels_path
  end

private

def novel_params
  params.require(:novel).permit(:title, :text_body, :image, :caption, :privacy)
end

def ensure_novel
  @novels = current_user.novels
  @novel = @novels.find_by(id: params[:id])
  # 自分以外の小説の情報合致していないとunlessになる
  redirect_to novels_path unless @novel
  # unlessだった場合自分の小説一覧に飛ぶ
end


end
