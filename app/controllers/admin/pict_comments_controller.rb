class Admin::PictCommentsController < ApplicationController
  def index
    @pict_comments = PictComment.all
  end

  private

  def pict_comment_params
    params.require(:pict_comment).permit(:comment)
  end

end
