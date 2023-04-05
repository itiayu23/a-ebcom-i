class Novel < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  with_options presence: true do
    validates :text_body
    validates :title
  end


end
