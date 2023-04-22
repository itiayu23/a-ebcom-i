class Novel < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :write_tags, dependent: :destroy
  has_many :tags, through: :write_tags,dependent: :destroy
  # 閲覧数
  has_many :read_counts, dependent: :destroy

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
  
       savenovel_tags.each do |new_name|
       novel_tag = Tag.find_or_create_by(name: mew_name)
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


end
