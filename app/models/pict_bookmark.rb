class PictBookmark < ApplicationRecord
  
  belongs_to :user
  belongs_to :pict
  
  # 一つの作品に対してそのユーザーは一つしかブックマークできない
  validates_uniqueness_of :novel_id, scope: :user_id
  
end
