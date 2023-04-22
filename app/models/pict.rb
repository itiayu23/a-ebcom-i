class Pict < ApplicationRecord

  belongs_to :user
  has_many_attached :image
  has_many :pict_comments, dependent: :destroy
  has_many :pict_bookmarks, dependent: :destroy
  has_many :draw_tags, dependent: :destroy
  has_many :pict_tags, through: :draw_tags, dependent: :destroy
  # 閲覧数
  has_many :read_counts, dependent: :destroy
  
    # 一覧の新着順と古い順
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
         
   def pict_bookmarked_by?(user)
       pict_bookmarks.exists?(user_id: user.id)
   end
        
  def save_tags(savepict_tags)
       current_tags = self.tags.pluck(:name) unless self.tags.nil?
       old_tags = current_tags - savepict_tags
       new_tags = savepict_tags - current_tags
  
       old_tags.each do |old_name|
       self.tags.delete Tag.find_by(name: old_name)
       end
  
       savepict_tags.each do |new_name|
       pict_tag = Tag.find_or_create_by(name: new_name)
       self.tags << pict_tag
      end
  end
         

  with_options presence: true do
    validates :image
    validates :title
  end

end
