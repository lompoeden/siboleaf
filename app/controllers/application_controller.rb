class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
    include SessionsHelper
    def authenticate_user
      # If the currently logged-in user does not exist, redirect to the login page.
      #if @current_user == nil
         unless logged_in?
        flash[:warning] = 'Please login first!'
        redirect_to new_session_path
      end
    end
  end
