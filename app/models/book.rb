class Book < ApplicationRecord
	belongs_to :user
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	validates :title, presence: true
	validates :opinion, presence: true, length: { maximum: 200 }

	def favorite_user(user_id)
		favorites.find_by(user_id: user_id)
	end


end
