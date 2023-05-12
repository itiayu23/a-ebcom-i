class User::CommentsController < ApplicationController

  def create
    @novel = Novel.find(params[:novel_id])
    @comment = current_user.comments.new(novel_id: @novel.id, comment: comment_params[:comment])
    @comment.score = Language.get_data(comment_params[:comment])
    if @comment.save!
    # 通知の作成
    @comment_novel.create_notification_comment!(current_user, @comment.id)
    render :index
    end
    
    
  end

  def destroy
    @novel = Novel.find(params[:novel_id])
    Comment.find(params[:id]).destroy
  end


  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
