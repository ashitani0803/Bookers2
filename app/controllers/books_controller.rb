class BooksController < ApplicationController

  before_action :authenticate_user!

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @bookn = Book.new
    @comment = BookComment.new
    @comments = BookComment.all
  end

  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = @book.user
    if @book.save
      redirect_to book_path(@book.id)
      flash[:notice] = 'You have created book successfully.'
    else
      render :index
    end
  end


  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id)
      flash[:notice] = 'You have updated book successfully.'
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :opinion)
  end
end
