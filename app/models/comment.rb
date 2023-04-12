class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :novel
  belongs_to :pict
  
  validates :comment, presence: true, length: {maximum: 300}
  
end
