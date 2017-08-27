class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # helper method gives access to the views
  helper_method :current_user, :logged_in?


  def current_user
    return nil unless session[:session_token]
    @current ||= User.find_by(session_token: session[:session_token])
  end

  def log_in(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def log_out
    current_user.destroy
  end

  def logged_in?
    !current_user.nil?
  end

  def not_logged_in?
    current_user.nil?
  end
  private

  def band_params
    params.require(:band).permit(:name)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_digest, :session_token)
  end

  def album_params
    params.require(:album).permit(:title, :year, :band_id, :studio)
  end
end
