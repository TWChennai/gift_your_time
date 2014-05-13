class EventsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]

  def index
    @events = Event.all #TODO: all_future_events
    respond_to do |format|
      format.html
      format.json { render json: @events.to_json }
    end
  end

  def new
    flash[:error] = "You must sign in to add an event!"
    redirect_to new_user_session_path and return unless user_signed_in?
    @event = Event.new(date: Date.today, user_id: current_user.id)
  end

  def create
    @event = Event.new(event_parameters)
    @event.save!
    redirect_to events_path
  rescue
    render :new, status: 400
  end

  def show
    @event = Event.find(params[:id])
    @all_comments = @event.comments
    @comment = Comment.new(event_id: @event.id, user_id: current_user.id)
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.user_id == current_user.id
      @event.destroy
      redirect_to events_path
    end
  end

  def edit
    @event = Event.find(params[:id])
    render :edit
  end

  def update
    @event = Event.find(params[:id])
    if @event.user_id != current_user.id
      redirect_to events_url
    else
      @event.name = params[:event][:name]
    end
    if @event.save
      redirect_to events_url
    else
      render :edit
    end
  end

  private
  def event_parameters
    params.require(:event).permit(:date, :start_time, :end_time, :name, :description, :user_id)
  end
end
