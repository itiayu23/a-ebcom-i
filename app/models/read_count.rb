class ReadCount < ApplicationRecord
  belongs_to :user
  belongs_to :novel
  belongs_to :pict
end
