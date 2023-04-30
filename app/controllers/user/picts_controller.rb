class User::PictsController < ApplicationController
  before_action :ensure_pict, only:[:edit, :update, :destroy]

  def new
    @pict_new = Pict.new
  end

  def create
     # 下書きを後で追加する
    @pict_new = Pict.new(pict_params)
    @pict_new.user_id = current_user.id

    tag_list = params[:pict][:pict_tag_ids].split(',')

    if @pict_new.save
      @pict_new.save_pict_tags(tag_list)
      flash[:notice] = "作品が投稿されました"
      redirect_to pict_path(@pict_new.id)
    else
      @user = current_user
      @picts = @user.picts
      render :show
    end
  end

  def show
    @pict = Pict.find(params[:id])
    @pict_comment = PictComment.new
    @user = @pict.user

   if user_signed_in?
     current_user.read_counts.create(pict_id: @pict.id)
   end
  end

  def index
    @q_pict = PictTag.ransack(params[:q])

    if params[:latest]
      @picts = Pict.where(privacy: "1").latest.page(params[:page])
    elsif params[:old]
      @picts = Pict.old.where(privacy: "1").page(params[:page])

    elsif  params[:q].present?

      @picts = Pict.where(id: DrawTag.where(pict_tag_id: @q_pict.result.order(created_at: :desc).pluck(:id)).pluck(:pict_id)).where(privacy: "1").page(params[:page]) || Pict.where(privacy: "1").page(params[:page])

    else
      @picts = Pict.where(privacy: "1").page(params[:page])
    end
  end

  def edit
    @pict = Pict.find(params[:id])
    @pict_tag_list = @pict.pict_tags.pluck(:name).join(",")
  end

  def update
  @pict = Pict.find(params[:id])
  @pict_tag_list = params[:pict][:pict_tag_ids].split(',')

    if @pict.update(pict_params)
      @pict.save_pict_tags(@pict_tag_list)
      flash[:notice] = "作品が更新されました"
      redirect_to pict_path(@pict.id)
    else
      render :edit
    end
  end

  def destroy
    pict = Pict.find(params[:id])
    pict.destroy
    redirect_to picts_path
  end

  private

  def pict_params
    params.require(:pict).permit(:title, :caption, :privacy, image: [])
  end

  def ensure_pict
  @picts = current_user.picts
  @pict = @picts.find_by(id: params[:id])
  # 自分以外のイラストの情報合致していないとunlessになる
  redirect_to picts_path unless @pict
  # unlessだった場合自分のイラスト一覧に飛ぶ
  end
  
  # def is_matching_login_user
  #   user_id = params[:id].to_i
  #   unless  
      
    # end


end
