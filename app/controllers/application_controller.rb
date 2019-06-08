class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def require_login!
    if current_user.nil?
      redirect_to new_session_url
    end
  end

  def redirect_user!
    if current_user
      redirect_to user_url(current_user)
    end
  end

  def login_user!(user)
    token = user.reset_session_token!
    session[:session_token] = token
  end

  def logout_user!
    current_user.reset_session_token!
    session[:session_token] = nil
  end
end
