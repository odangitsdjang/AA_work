class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    u = User.find_by_credentials(user_params[:email], params[:user][:password])
    if u.nil?
      flash.now[:errors] = ["Invalid username or password"]
      render :new
    else
      log_in(u)
      redirect_to user_url(u.id)
    end
  end

  def destroy
    session[:session_token] = nil
    redirect_to new_sessions_url
    # current_user.reset_session_token
  end


end
