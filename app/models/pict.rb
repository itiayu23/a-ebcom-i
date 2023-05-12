class Pict < ApplicationRecord

  belongs_to :user
  has_many_attached :image
  has_many :pict_comments, dependent: :destroy
  has_many :pict_bookmarks, dependent: :destroy
  has_many :draw_tags, dependent: :destroy
  has_many :pict_tags, through: :draw_tags, dependent: :destroy
  # 閲覧数
  has_many :read_counts, dependent: :destroy
  
  # イラスト、マンガでいいねもらった時の通知
  has_many :notifications, dependent: :destroy
  
    # 一覧の新着順と古い順
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
         
   def pict_bookmarked_by?(user)
       pict_bookmarks.exists?(user_id: user.id)
   end
        
  def save_pict_tags(savepict_tags)
       current_pict_tags = self.pict_tags.pluck(:name) unless self.pict_tags.nil?
       old_pict_tags = current_pict_tags - savepict_tags
       new_pict_tags = savepict_tags - current_pict_tags
  
       old_pict_tags.each do |old_name|
       self.pict_tags.delete PictTag.find_by(name: old_name)
       end
  
       new_pict_tags.each do |new_name|
       pict_tag = PictTag.find_or_create_by(name: new_name)
       self.pict_tags << pict_tag
      end
  end
         

  with_options presence: true do
    validates :image
    validates :title
  end
  
    # 通知※要確認
  
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      pict_id: id,
      visited_id: user_id,
      action: "pict_bookmark"
      )
      notification.save if notification.valid?
  end
  
  def create_notification_pict_comment!(current_user, pict_comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = PictComment.select(:user_id).where(pict_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_pict_comment!(current_user, pict_comment_id, temp_id['user_id'])
    end
    
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_pict_comment!(current_user, pict_comment_id, user_id) if temp_ids.blank?
  end
  
  def save_notification_pict_comment!(current_user, pict_comment_id, user_id) if temp_ids.blank?
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      pict_id: id,
      pict_comment_id: pict_comment_id,
      visited_id: visited_id,
      action: 'pict_comment'
      )
       # 自分の投稿に対するコメントの場合は、通知済みとする
       if notification.visiter_id == notification.visited_id
         notification.checked = true
       end
       notification.save if notification.valid?
       end
  end
  

end
