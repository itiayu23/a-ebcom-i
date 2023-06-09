class PictComment < ApplicationRecord
  belongs_to :user
  belongs_to :pict
  
  validates :comment, presence: true, length: {maximum: 300}
  
  def create_notification_pict_comment!(current_user, user, pict_id)
      notification = current_user.active_notifications.new(
        visited_id: user.id,
        action: 'pict_comment',
        pict_comment_id: id,
        pict_id: pict_id
      )
      notification.save!
  end
  
end
