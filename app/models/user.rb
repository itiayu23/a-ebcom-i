class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :novels, dependent: :destroy
         has_many :picts, dependent: :destroy
         has_one_attached :profile_image
         has_many :pict_bookmarks, dependent: :destroy
         has_many :pict_comments, dependent: :destroy


        # 閲覧数
        has_many :read_counts, dependent: :destroy

        # フォローフォロワー
        has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
        has_many :reverse_of_relationships, class_name: "Relationship",foreign_key: "followed_id", dependent: :destroy

        # 一覧画面で使う
        has_many :followings, through: :relationships, source: :followed
        has_many :followers, through: :reverse_of_relationships, source: :follower

        # DMは後で実装
        has_many :entries, dependent: :destroy
        has_many :messages, dependent: :destroy

        # プロフィール画像何もないときのやつ
    def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [100, 100]).processed
    end

    # フォローした時の処理
    def follow(user_id)
      relationships.create!(followed_id: user_id)
    end
    # フォロー外すときの処理
    def unfollow(user_id)
      relationships.find_by(followed_id: user_id).destroy
    end

    # フォローしているかの判定
    def following?(user)
      followings.include?(user)
    end


    # バリデーション
    validates :name, uniqueness: true, presence: true
    validates :nickname, uniqueness: true, presence: true, length: {maximum: 30, minimum: 2}
    validates :profile, length: {maximum:255}
    validates :email, uniqueness:true, presence: true
    validates :birthday, presence: true

    # 検索方法分岐
    def self.looks(search, word)

      if search == "perfect_match"
        @user = User.where("name LIKE?", "#{word}")

      elsif search == "forward_match"
          @user = User.where("name LIKE?","#{word}%")

      elsif search == "backward_match"
            @user = User.where("name LIKE?", "%#{word}")

      elsif search == "partial_match"
              @user = User.where("name LIKE?", "%#{word}%")

      else
              @user = User.all
      end
    end

end
