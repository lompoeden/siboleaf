class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.order('id ASC')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: 'The User was created successfully'
    else
      render.new
    end
  end

  def show
    @tasks = Task.all
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'The User details was updated successfully'
    else
      render :edit
    end
  end

  def destroy
     if @user.id == current_user.id
       redirect_to admin_users_url, notice: "You cannot delete Signed In user"
       @admins = User.admin
     elsif @admins == 1
       redirect_to admin_users_url, notice: "At least one admin must remain!"
     else
       @user.destroy
       redirect_to admin_users_url, notice: 'User was successfully deleted.'
     end
   end
   private

  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:username, :email, :password,
                                 :password_confirmation, :admin)
  end
end
