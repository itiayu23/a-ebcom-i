class User::BookmarksController < ApplicationController
  # before_action :set_user, only: [:index]

  def index
    bookmarks = Bookmark.where(user_id: @user.id).pluck(:novel_id)
    @bookmark_novels = Novel.find(bookmarks)
    # @bookmark_picts = Pict.find(bookmarks)
  end

  def create
    @novel = Novel.find(params[:novel_id])
    # @pict = Pict.find(params[:pict_id])
    @bookmark = current_user.bookmarks.new(novel_id: @novel.id)
    @bookmark.save
  end

  def destroy
    @novel = Novel.find(params[:novel_id])
    # @pict = Pict.find(params[:pict_id])
    @bookmark = current_user.bookmarks.find_by(novel_id: @novel.id)
    @bookmark.destroy
  end

  private

  # def set_user
  #   @user = User.find(params[:id])
  # end

end
