class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :admin_necessary
  PER = 6

  def index
    @users = User.select( :username, :email, :admin).order(created_at: :asc)
  end

  def new
    if logged_in?
        redirect_to tasks_path
      else
        @user = User.new
      end
    end

    def edit
    end

  def create
    @user = User.new(user_params)
    if @user.save
      if logged_in? && current_user.admin
      flash[:success] = "new user added"
      redirect_to admin_users_path(@user.id)
    else
      session[:user_id] = @user.id
      redirect_to user_path(@user.id), notice: 'User was successfully created.'
      end
    else
      flash.now[:danger] = "User registration failed"
      render :new
    end
  end

  def show
    @tasks = Task.where(user_id: @user.id).page(params[:page]).per(PER)
  end



  def update
    puts @user
    if @user.update(user_params)
      flash[:success] = "update successful"
      redirect_to admin_user_path(@user)
    else
      flash.now[:danger] = "update failed"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "user deleted!"
      redirect_to admin_users_path
    else
      flash[:danger] = "user not deleted"
      redirect_to admin_users_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def admin_necessary
    unless current_user.admin?
      flash[:danger] = "only for admins！"
      redirect_to tasks_path
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :admin)
  end
end
