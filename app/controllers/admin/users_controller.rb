class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :only_admin_can_access_management_page, only: [:index]
  PER = 4

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
      flash.now[:danger] = "User registration failed"
      render.new
    end
  end

  def show
    @tasks = Task.all
   @tasks = @tasks.page(params[:page]).per(PER)
  end

  def edit
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

  def only_admin_can_access_management_page
      unless current_user.admin == true
        redirect_to root_path, notice: "only  admin can access management page"
      end
    end

    def user_params
      params.require(:user).permit(:username, :email, :password,
                                   :password_confirmation, :admin)
    end
  end
