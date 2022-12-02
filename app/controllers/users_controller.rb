class UsersController < ApplicationController
  before_action :set_users, only: %i[show edit update destroyz]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    if @user.save
      # handle a successful save
    else
      render 'new'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Welcome to the Sample app'
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def set_users
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
