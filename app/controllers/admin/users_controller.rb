module Admin
  class UsersController < ApplicationController
    before_action :check_if_current_user_is_admin
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    # GET /users
    def index
      @users = User.includes(:tasks).all.order(created_at: :desc)
    end

    # GET /users/1
    def show
    end

    # GET /users/new
    def new
      if logged_in?
        redirect_to tasks_path
      else
        @user = User.new
      end
    end

    # GET /users/1/edit
    def edit
    end

    # POST /users
    def create
      @user = User.new(user_params)
      if @user.save
        if logged_in? && current_user.admin
          redirect_to admin_users_path
        else
          session[:user_id] = @user.id
          redirect_to user_path(@user.id), notice: 'User was successfully created.'
        end
      else
        render :new
      end
    end

    # PATCH/PUT /users/1
    def update
      if @user.update(user_params)
        redirect_to admin_users_path, notice: 'User was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /users/1
    def destroy
      if @user.destroy
        redirect_to admin_users_path, notice: 'User was successfully destroyed.'
      else
        redirect_to admin_users_path, notice: 'can not delete last admin'
      end
    end

    private

    def check_if_current_user_is_admin
      if !logged_in?
        redirect_to new_session_path, notice: "you are not authorized to access this page"
      elsif !current_user.admin?
        redirect_to tasks_path, notice: "you are not authorized to access this page"
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:email, :username, :admin,:password, :password_confirmation)
    end
  end
end
