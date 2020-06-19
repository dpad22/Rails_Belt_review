class UsersController < ApplicationController

    skip_before_action :require_login, :only => [:create, :new]
    # callback to validate user 
    before_action :check_user, only: [:edit, :show, :update, :delete]

    def new
    # renders new user page
    end

    def create

        @user = User.new(userParams)

        p @user.email
            if @user.valid?

                @user.save
                redirect_to login_url
            else

                redirect_to login_url, notice: "Invalid Registration submission"
            end
    end
        
    def show
        @user = User.find(params[:id])
        @events = Event.all
    end

    def edit
        @user = current_user
    end

    def update
        user = current_user
        p "^^^^^^^^^^^^^^^^^^^^^"
        p user
        # checks password
        if userParams[:password].blank?
            userParams.delete(:password)
            userParams.delete(:password_confirmation)
        end
        p "^^^^^^^^^^^^^^^^^^^^^^"
        user.fname = userParams[:fname]
        user.lname = userParams[:lname]
        user.email = userParams[:email]
        user.location = userParams[:location]
        user.state = userParams[:state]
        p user
        p"&&&&&&&&&&&&&&&&&&&&&&&&&&"
        user.save
        if user.errors.any?
            p user.errors.full_messages
        end
        if user.valid?
            p '***********************'
            p user
            redirect_to "/events"
        else
            redirect_to "/events", notice:"Invalid update. Unable to save user."
        end
    end
    
    private

    def userParams
        params.require(:user).permit(:fname, :lname, :email, :location, :state, :password, :password_confirmation)
    end
    
    private 

    def updateParams
        params.require(:user).permit(:fname,:lname,:email,:location,:state)
    end

    private
    def check_user
        if current_user != User.find(params[:id])
            redirect_to "/users/#{session[:user_id]}"
        end
    end

end




