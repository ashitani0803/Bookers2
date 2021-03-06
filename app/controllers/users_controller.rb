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
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  	  redirect_to user_path(@user.id)
      flash[:notice] = 'You have updated user successfully.'
    else
      render :edit
    end
  end

  def following
    @book = Book.new
    @user = User.find(params[:id])
    @users = @user.followed_users
    render 'show_follow'
  end

  def followers
    @book = Book.new
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  def search
    @users = User.search(params[:search], params[:search_select], params[:search_method])
  end


  private

  def user_params
  	params.require(:user).permit(:username, :image, :introduction)
  end

end
