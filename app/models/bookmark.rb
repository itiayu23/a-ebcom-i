class Bookmark < ApplicationRecord
  
  belongs_to :user
  belongs_to :pict
  belongs_to :novel
  
  
  validates_uniqueness_of 
  
end
