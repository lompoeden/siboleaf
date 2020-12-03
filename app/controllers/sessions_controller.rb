class SessionsController < ApplicationController
    def index
        render "new"
    end

    def new
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            if user.admin
                redirect_to admin_users_path, notice: 'admin page'
            else
                redirect_to tasks_path, notice: 'logged in'
            end
        else
            render "new"
        end
    end

    def destroy
        session.delete(:user_id)
        redirect_to new_session_path
    end
end
