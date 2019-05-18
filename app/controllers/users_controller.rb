class UsersController < ApplicationController

  before_action :authenticate_user!, except: [:home, :about]

  def home
  end

  def about
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def show
  	@user = User.find(params[:id])
    @book = Book.new
    @books = Book.all
  end


  def edit
  	@user = User.find(params[:id])
  end

  def update
  	user = User.find(params[:id])
  	user.update(user_params)
  	redirect_to user_path(user.id)
    flash[:notice] = 'You have updated user successfully.'
  end

  private

  def user_params
  	params.require(:user).permit(:username, :image, :introduction)
  end

end
