class Pict < ApplicationRecord

  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  # 閲覧数
  has_many :read_counts, dependent: :destroy
  
    # 一覧の新着順と古い順
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
         
         

  with_options presence: true do
    validates :image
    validates :title
  end

end
