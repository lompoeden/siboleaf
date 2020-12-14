class UsersController < ApplicationController
  before_action :authenticate_user, { only: [:index, :show, :edit, :update] }
  PER = 6

  def index
      if logged_in? && current_user.admin?
        redirect_to admin_users_path
      else
        redirect_to new_session_path
      end
    end

  def new
    @user = User.new
    if logged_in?
      redirect_to tasks_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'User was successfully created'
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = current_user
    @tasks = @user.tasks&.page(params[:page]).per(PER)
    redirect_to tasks_path if @user.id !=  params[:id].to_i
  end

  def update
    if @user.update(user_params)
      if current_user.admin
      redirect_to admin_user_path
    else
      redirect_to @user, notice: 'User was successfully updated.'
      end
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = 'Task not deleted'
    redirect_to admin_users_path
  end

  private
  def set_user
      @user = User.find(params[:id])
    end


  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
