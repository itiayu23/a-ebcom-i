class WriteTag < ApplicationRecord
  belongs_to :novel
  belongs_to :tag
end
