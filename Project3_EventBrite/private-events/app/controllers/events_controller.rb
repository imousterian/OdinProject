class EventsController < ApplicationController
    before_action :find_correct_event, only: [:show, :register, :accept_request]

    def new
        @event = current_user.events.build
    end

    def create
        @event = current_user.events.build(event_params)
        if @event.save
            flash[:notice] = 'Successfully created a new event.'
            redirect_to current_user
        else
            render 'new'
        end
    end

    def show
        @attendees = @event.approved_attendees(@event.id)
    end

    def index
        if params[:event_date] == :all
            @events = Event.all
        elsif params[:event_date] == 'past'
            @events = Event.past_events
        elsif params[:event_date] == 'upcoming'
            @events = Event.upcoming_events
        else
            @events = Event.all
        end
    end

    def register
        if current_user.id != @event.creator_id
            if @event.status != "Invitation Only"
                @event.attendances.create!(attendee_id: current_user.id)
                respond_to do |format|
                    format.html {redirect_to @event, :notice => "Thanks for registering!"}
                end
            else
                @registration_request = Attendance.join_event(current_user.id, @event.id, 'request_sent')
                respond_to do |format|
                    format.html {redirect_to @event, :notice => "Thanks, we will notify you."}
                end
            end
        else
            respond_to do |format|
                format.html {redirect_to root_url, :alert => "Can't join own event."}
            end
        end
    end

    def accept_request
        @attendance = Attendance.find_by(id: params[:attendance_id]) rescue nil
        @attendance.approve(:state, 'approved')
        respond_to do |format|
            if @attendance.save
                format.html { redirect_to @event, :notice => 'Approved!' }
            end
        end
    end

    private
        def event_params
            params.require(:event).permit(:title, :description, :location, :date, :status)
        end
        def find_correct_event
            @event = Event.find(params[:id])
        end
end
