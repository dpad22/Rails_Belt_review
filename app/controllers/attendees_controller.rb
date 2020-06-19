class AttendeesController < ApplicationController

    def create
        @user = current_user
        @event = Event.find(params[:id])
        @attendee = Attendee.new(user: @user, event:@event)
            if @attendee.valid?
                @attendee.save
                redirect_to "/events"
            else
                redirect_to "/events", notice: "Event attendee error"
            end
    end

    def destroy
        @user = current_user
        @event = Event.find(params[:id])
        @attendee = Attendee.find_by(user: @user, event: @event)
            if @attendee.valid?
                @attendee.destroy
                redirect_to "/events"
            else
                redirect_to "/events", notice: "Error removing event attendee"
            end
    end

    private
    def check_user
        @attendee = Attendee.find_by(params[:id])
        if current_user != @attendee.user
            redirect_to "/event/#{session[:user_id]}"
        end
    end

end
