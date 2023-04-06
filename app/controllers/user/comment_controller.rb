class User::CommentController < ApplicationController

  def create
    @novel = Novel.find(params[:novel_id])
    @pict = Pict.find(params[:pict_id])
    @comment = current_user.comment.new(novel_id: @novel.id, pict_id: @pict.id)
    @comment.save
  end

    def destroy
    @novel = Novel.find(params[:novel_id])
    @pict = Pict.find(params[:pict_id])
    Comment.find(params[:id]).destroy
  end


  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

  end
