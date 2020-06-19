class EventsController < ApplicationController
    def index
        @events = Event.all
        @user = current_user
        # @events.each do |event|
        #     date = event.date.strftime('%B %d %Y')
        # p "************************"
        # p date
        # end
    end

    def create
        @event = Event.create(eventParams)
            if @event.valid?
                # date = @event.date.strftime('%B %d %Y')
                # p '^^^^^^^^^^^^^^^^^'
                # p date
                Attendee.create(user: current_user,event:@event)
                redirect_to "/events"
            else
                flash[:errors] = ['Invalid Event. Please enter valid Event']
                redirect_to "/events"
            end
    end

    def show
        @event = Event.find(params[:id])
        @users = @event.attending
        @attendees = Attendee.where(event:@event)
        @comments = @event.comments
    end

    def edit
        @user = current_user
        @event = Event.find(params[:id])
    end

    def update
        @user = current_user
        @event = Event.find(params[:id])
        @event.name = eventParams[:name]
        @event.date = eventParams[:date]
        @event.location = eventParams[:location]
        @event.state = eventParams[:state]
        @event.save
        if @event.valid?
            redirect_to "/events"
        else
            redirect_to "/events", notice: "Unable to update Event"
        end
    end

    def destroy
        @user = current_user
        event = Event.find(params[:id])
        if event.user == @user
            event.destroy
        end
        redirect_to '/events'
    end

    private

    def eventParams
        params.require(:event).permit(:name,:date,:location,:state).merge(user:current_user)
    end


end
