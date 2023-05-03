class Admin::CommentsController < ApplicationController
  def index
    #@novel = Novel.find(params[:novel_id])
    @comments = Comment.all
    
  end

  private


def comment_params
  params.require(:comment).permit(:comment)
end

end
