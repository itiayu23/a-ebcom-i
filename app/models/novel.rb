class Novel < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  # 閲覧数
  has_many :read_counts, dependent: :destroy
         

  with_options presence: true do
    validates :text_body
    validates :title
  end


end
