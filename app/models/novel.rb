class Novel < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :write_tags, dependent: :destroy
  has_many :tags, through: :write_tags,dependent: :destroy
  # 閲覧数
  has_many :read_counts, dependent: :destroy
  
  # 小説でいいねもらった時の通知
  has_many :notifications, dependent: :destroy


  # 一覧の新着順と古い順
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}


def save_tags(savenovel_tags)
       current_tags = self.tags.pluck(:name) unless self.tags.nil?
       old_tags = current_tags - savenovel_tags
       new_tags = savenovel_tags - current_tags
  
       old_tags.each do |old_name|
       self.tags.delete Tag.find_by(name: old_name)
       end
  
       new_tags.each do |new_name|
       novel_tag = Tag.find_or_create_by(name: new_name)
       self.tags << novel_tag
      end
end
      


   def bookmarked_by?(user)
     bookmarks.exists?(user_id: user.id)
   end


  with_options presence: true do
    validates :text_body
    validates :title
  end
  
  
  # 通知
  
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      novel_id: id,
      visited_id: user_id,
      action: "bookmark"
      )
      notification.save if notification.valid?
  end
  
  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(novel_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end
  
  def save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      novel_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
      )
       # 自分の投稿に対するコメントの場合は、通知済みとする
       if notification.visiter_id == notification.visited_id
         notification.checked = true
       end
       notification.save if notification.valid?
       end
  end
  
  
    


end
