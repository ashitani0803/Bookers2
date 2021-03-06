class BookCommentsController < ApplicationController

	def create
		book = Book.find(params[:book_id])
		comment = current_user.book_comments.new(book_comment_params)
		comment.book_id = book.id
		comment.save
		redirect_to book_path(book.id)
	end

	def edit
		@book = Book.find(params[:book_id])
		@comment = @book.book_comments.find(params[:id])
	end

	def update
		@book = Book.find(params[:book_id])
		@comment = @book.book_comments.find(params[:id])
		@comment.update(book_comment_params)
		redirect_to book_path(@book.id)
	end

	def destory
		@book = Book.find(params[:book_id])
		@comment = @book.book_comments.find(params[:id])
		@comment.destory
		redirect_to book_path(@book.id)
	end

	private

	def book_comment_params
		params.require(:book_comment).permit(:user_id, :book_id, :comment)
	end

end
