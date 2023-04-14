class User::PictBookmarksController < ApplicationController
   before_action :set_user, only: [:index]

  def index
    bookmarks = Bookmark.where(user_id: @user.id).pluck(:pict_id)
    @bookmark_picts = Pict.find(bookmarks)
    # @bookmark_picts = Pict.find(bookmarks)
  end

  def create
    @pict = Pict.find(params[:pict_id])
    @pict_bookmark = current_user.pict_bookmarks.new(pict_id: @pict.id)
    @pict_bookmark.save
  end

  def destroy
    @pict = Pict.find(params[:pict_id])
    @pict_bookmark = current_user.pict_bookmarks.find_by(pict_id: @pict.id)
    @pict_bookmark.destroy
  end

  private

  # def set_user
  #   @user = User.find(params[:id])
  # end

end
