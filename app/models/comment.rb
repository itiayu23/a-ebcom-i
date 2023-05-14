class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :novel
  
  validates :comment, presence: true, length: {maximum: 300}
   def create_notification_comment!(current_user, user)
      notification = current_user.active_notifications.new(
        visited_id: user.id,
        action: 'comment',
        comment_id: id
      )
      notification.save!
   end
end
