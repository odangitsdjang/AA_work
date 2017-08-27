class UsersController < ApplicationController
  before_action :not_logged_in?, only:  [:create, :new]
  # before_action :ensure_logged?, only: [:show]
  # show all users only for testing purposes
  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user
      render :show
    else
      render text: "wrong user"
    end
  end

  def new
    render :new
  end

  def create
    u = User.new(user_params)
    if u.save
      log_in(u)
      redirect_to user_url(u)
    else
      flash[:errors] = [u.errors.full_messages]
      redirect_to new_user_url
    end
  end

end
