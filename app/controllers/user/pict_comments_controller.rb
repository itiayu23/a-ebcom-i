class User::PictCommentsController < ApplicationController
  def create
    @pict = Pict.find(params[:pict_id])
    @comment = current_user.pict_comments.new(pict_id: @pict.id, comment: pict_comment_params[:comment])
    @comment.score = Language.get_data(pict_comment_params[:comment])
    if @comment.save!
        # 通知の作成
    @comment_pict.create_notification_comment!(current_user, @comment.id)
    render :index
    end
  end

  def destroy
    @pict = Pict.find(params[:pict_id])
    PictComment.find(params[:id]).destroy
  end


  private

  def pict_comment_params
    params.require(:pict_comment).permit(:comment)
  end
end
