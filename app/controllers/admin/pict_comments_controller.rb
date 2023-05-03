class Admin::PictCommentsController < ApplicationController
  def index
    @pict_comments = PictComment.all
  end
end
