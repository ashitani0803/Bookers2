class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship",dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  attachment :image

  validates :username, presence: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }

  def following?(other_user)
  	relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
  	relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
  	relationships.find_by(followed_id: other_user.id).destroy
  end

  def self.search(search, search_select, search_method)
    if search
      if search_select == "ユーザー"
        if search_method == '前方一致検索'
          User.where(['username LIKE ?', "#{search}%", "#{search}%"])
        elsif search_method == '後方一致検索'
          User.where(['username LIKE ?', "%#{search}", "%#{search}"])
        elsif search_method == '完全一致検索'
          User.where(['username LIKE ?', "#{search}", "#{search}"])
        elsif search_method == '部分一致検索'
          User.where(['username LIKE ?', "%#{search}%", "%#{search}%"])
        end
      end
    else
      User.all
    end
  end

end
