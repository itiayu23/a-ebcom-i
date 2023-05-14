module User::NotificationsHelper

  def notification_form(notification)
    @visiter = notification.visiter
    @comment = nil
    your_novel = link_to 'あなたの投稿',novel_path(notification), style:"font-weight: bold;"
    your_pict = link_to 'あなたの投稿',pict_path(notification), style:"font-weight: bold;"
    @visiter_comment = notification.comment_id
    @visiter_pict_comment = notification.pict_comment_id
    #notification.actionがfollowかlikeかcommentか
    case notification.action
      when "follow" then
        tag.a(notification.visiter.name, href:user_page_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしました"
      when "bookmark" then
        tag.a(notification.visiter.name, href:user_page_path(@visiter), style:"font-weight: blod;")+"が"+tag.a('あなたの投稿', href:novel_path(notification.novel_id), style:"font-weight: bold;")+"にいいねしました"
      when "pict_bookmark" then
        tag.a(notification.visiter.name, href:user_page_path(@visiter), style:"font-weight: blod;")+"が"+tag.a('あなたの投稿', href:pict_path(notification.pict_id), style:"font-weight: bold;")+"にいいねしました"
      when "comment" then
           @comment = Comment.find_by(id: @visiter_comment)&.comment
           tag.a(@visiter.name, href:user_page_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href: notification.novel_id.present? ? novel_path(notification.novel_id) : root_path, style:"font-weight: bold;")+"にコメントしました"
      when "pict_comment" then
           @comment = PictComment.find_by(id: @visiter_pict_comment)&.comment
           tag.a(@visiter.name, href: @visiter.present? ? user_page_path(@visiter) : root_path, style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href: notification.pict_id.present? ? pict_path(notification.pict_id) : root_path, style:"font-weight: bold;")+"にコメントしました"
    end

  end

  def unchecked_notifications
      @notifications = current_user.passive_notifications.where(checked: false)
  end

end
