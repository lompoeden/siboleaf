class UsersController < ApplicationController
  before_action :authenticate_user, { only: [:index, :show, :edit, :update] }
  PER = 4

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
    @user = User.find(params[:id])
    @tasks = Task.all
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path
    else
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
    def only_create_user_when_none_signed_in
      if current_user
        redirect_to users_path,  notice: "you can't create user when signed in"
      end
    end
    def only_see_own_page
      @user = User.find(params[:id])
      if current_user != @user
        redirect_to users_path, notice: "Sorry, but you are only allowed to view your own profile page."
      end
    end

  def user_params
    params.require(:user).permit(:username, :email, :password,
                                 :password_confirmation)
  end
end
