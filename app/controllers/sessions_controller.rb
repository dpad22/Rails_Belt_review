class SessionsController < ApplicationController

    skip_before_action :require_login
    
    def new
        # render login page
    end

    def create
        # user login
        user = User.where(email: params[:user][:email])
        if !user.empty?
            if user[0].authenticate(params[:user][:password])
                session[:user_id] = user[0].id
                flash[:notice] = "Welcome, You have successfully signed in!"
                redirect_to "/events"
            else
                redirect_to login_url, notice: "Invalid Login Attempt. Please try again"
            end
        else
            redirect_to login_url, notice: "Invalid Login Attempt. Please try again"
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to login_url
    end

    private

    def login_user!(user)
        session[:user_id] = user.id
        flash[:notice] = "Welcome, You have successfully signed in!"
        redirect_to '/'
    end

end
