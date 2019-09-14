class Book < ApplicationRecord
	belongs_to :user
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	validates :title, presence: true
	validates :opinion, presence: true, length: { maximum: 200 }

	def favorite_user(user_id)
		favorites.find_by(user_id: user_id)
	end

	def self.search(search, search_select, search_method)
		if search
			if search_select == "投稿"
				if search_method == '前方一致検索'
					Book.where(['title LIKE ? OR opinion LIKE ?', "#{search}%", "#{search}%"])
				elsif search_method == '後方一致検索'
					Book.where(['title LIKE ? OR opinion LIKE ?', "%#{search}", "%#{search}"])
				elsif search_method == '完全一致検索'
					Book.where(['title LIKE ? OR opinion LIKE ?', "#{search}", "#{search}"])
				elsif search_method == '部分一致検索'
					Book.where(['title LIKE ? OR opinion LIKE ?', "%#{search}%", "%#{search}%"])
				end
			end
		else
			Book.all
		end
	end
end
