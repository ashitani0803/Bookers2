class FavoritesController < ApplicationController

	before_action :set_variables

	def create
		@favorite = Favorite.create(user_id: current_user.id, book_id: params[:book_id])
		@favorites = Favorite.where(book_id: params[:book_id])
		@book.reload
	end

	def destroy
		favorite = Favorite.find_by(user_id: current_user.id, book_id: params[:book_id])
		favorite.destroy
		@favorites = Favorite.where(book_id: params[:book_id])
		@book.reload
	end

	private

	def set_variables
		@book = Book.find(params[:book_id])
	end

end
