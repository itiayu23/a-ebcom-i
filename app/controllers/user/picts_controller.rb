class User::PictsController < ApplicationController
  before_action :ensure_pict, only:[:edit, :update, :destroy]
  
  def new
    @pict_new = Pict.new
  end
  
  def create
     # 下書きを後で追加する
    @pict_new = Pict.new(pict_params)
    @pict_new.user_id = current_user.id
    if @pict_new.save
      flash[:notice] = "作品が投稿されました"
      redirect_to user_picts_show(@pict_new.id)
    else
      @user = current_user
      @picts = @user.picts
      render :show
    end
  end

  def show
    @pict = Pict.find(params[:id])
    @comment = Comment.new
    @user = @pict.user
    current_user.read_counts.create(pict_id: @pict.id)
  end

  def index
    if params[:latest]
      @picts = Pict.latest
    elsif params[:old]
      @picts = Pict.old
    else
      @picts = Pict.all
    end
  end

  def edit
    @pict = Pict.find(params[:id])
  end
  
  def update
  @pict = Pict.find(params[:id])
    if @pict.update(pict_params)
      flash[:notice] = "作品が更新されました"
      redirect_to user_picts_show_path(@pict.id)
    else
      render :edit
    end
  end
  
  def destroy
    pict = Pict.find(params[:id])
    pict.destroy
    redirect_to user_picts_show_path
  end
  
  private
  
  def pict_params
    params.require(:pict).permit(:title, :caption, image: [])
  end
  
  def ensure_pict
  @picts = current_user.picts
  @pict = @picts.find_by(id: params[:id])
  # 自分以外のイラストの情報合致していないとunlessになる
  redirect_to user_picts_show_path unless @pict
  # unlessだった場合自分のイラスト一覧に飛ぶ
  end
  
  
end
