class PictTag < ApplicationRecord
  #Tagsテーブルから中間テーブルに対する関連付け
  has_many :draw_tags, dependent: :destroy
  #Tagsテーブルから中間テーブルを介してArticleテーブルへの関連付け
  has_many :picts, through: :draw_tags, dependent: :destroy
  
  validates :name, presence: true
  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
end
