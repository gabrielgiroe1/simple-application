class UsersController < ApplicationController
  before_action :set_users, only: %i[show edit update destroy]

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
      log_in @user
      flash[:success] = 'Welcome to the Sample app'
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'Successful update'
    else
      render 'edit'
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
