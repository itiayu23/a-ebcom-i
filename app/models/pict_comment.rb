class PictComment < ApplicationRecord
  belongs_to :user
  belongs_to :pict
  
  validates :comment, presence: true, length: {maximum: 300}
  
end
