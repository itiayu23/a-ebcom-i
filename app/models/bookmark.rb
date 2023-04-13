class Bookmark < ApplicationRecord
  
  belongs_to :user
  belongs_to :novel
  
  # 一つの作品に対してそのユーザーは一つしかブックマークできない
  validates_uniqueness_of :novel_id, scope: :user_id
  
end
