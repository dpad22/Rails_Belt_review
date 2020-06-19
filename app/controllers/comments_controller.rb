class CommentsController < ApplicationController

    def create
        @user = current_user
        @event = Event.find(params[:event_id])
        @comment = Comment.new(user:@user, event:@event, content: params['content'])
            if @comment.valid?
                @comment.save
                redirect_to "/events/#{@event.id}"
            else
                redirect_to "events/#{@event.id}", notice: "Invalid comment entry"
            end
    end
end
