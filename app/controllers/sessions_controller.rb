class SessionsController < ApplicationController
  before_action :require_login!, only: [:destroy]
  before_action :redirect_user!, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password])

    if @user
      login_user!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Incorrect username or password"]
      @user = User.new(user_params)
      render :new
    end
  end

  def destroy
    logout_user!
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
