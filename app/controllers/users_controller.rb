class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  #before_action :only_create_user_when_none_signed_in, only: [:new, :create]
  before_action :only_see_own_page, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to new_session_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = Task.all
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password,
                                 :password_confirmation)
  end
end
