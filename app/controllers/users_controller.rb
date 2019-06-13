class UsersController < ApplicationController
  before_action :require_login!, only: [:show, :index]
  before_action :redirect_user!, only: [:create, :new]

  def index
    @users = User.all
    render :index
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      login_user!(@user)
      redirect_to users_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user
      render :show
    else
      redirect_to user_url(current_user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
