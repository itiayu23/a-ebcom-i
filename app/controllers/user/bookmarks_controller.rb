class User::BookmarksController < ApplicationController
  # before_action :set_user, only: [:index]

  def index
    bookmarks = Bookmark.where(user_id: @user.id).pluck(:novel_id)
    @bookmark_novels = Novel.find(bookmarks)
    # @bookmark_picts = Pict.find(bookmarks)
  end

  def create
    @novel = Novel.find(params[:novel_id])
    
    @bookmark = current_user.bookmarks.new(novel_id: @novel.id)
    @bookmark.save
    
    # 通知の作成
    @novel.create_notification_by(current_user)
    respond_to do |format|
      format.html {redirect_to request.referrer}
        format.js
    end
    
  end

  def destroy
    @novel = Novel.find(params[:novel_id])
    @bookmark = current_user.bookmarks.find_by(novel_id: @novel.id)
    @bookmark.destroy
  end

  private

  # def set_user
  #   @user = User.find(params[:id])
  # end

end
