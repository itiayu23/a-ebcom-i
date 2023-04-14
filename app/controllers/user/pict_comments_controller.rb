class User::PictCommentsController < ApplicationController
  def create
    @pict = Pict.find(params[:pict_id])
    @comment = current_user.pict_comments.new(pict_id: @pict.id, comment: pict_comment_params[:comment])
    @comment.save!
  end

  def destroy
    @pict = Pict.find(params[:pict_id])
    PictComment.find(params[:id]).destroy
  end


  private

  def pict_comment_params
    params.require(:comment).permit(:comment)
  end
end
