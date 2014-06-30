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
    @event = Event.new(date: params[:date], user_id: current_user.id)
  end

  def create
    @event = Event.new(event_parameters)
    @event.save!
    redirect_to events_path
  rescue
    render :new, status: 400
  end

  def show
    @event = Event.where(id: params[:id]).limit(1)[0]
    @event_participants = @event.event_participation
    @all_comments = @event.comments
    @comment = Comment.new(event_id: @event.id, user_id: current_user.id) if user_signed_in?
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.user_id == current_user.id
      @participations = @event.event_participation
      score = ((@event.end_time - @event.start_time) / 1.hour).round
      for i in @participations
          i.user.score = i.user.score +  score
          i.user.save!
      end
      current_user.score = current_user.score - (score * @participations.length)
      current_user.save!
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
      @event.description = params[:event][:description]
      @event.date = params[:event][:date]
      oldEndTime = params[:event][:end_time].to_time.strftime("%H:%M")
      oldStartTime = params[:event][:start_time].to_time.strftime("%H:%M")
      if @event.start_time.strftime("%H:%M") != oldStartTime || @event.end_time.strftime("%H:%M") != oldEndTime
        @participations = @event.event_participation
        old_score = ((@event.end_time - @event.start_time) / 1.hour).round
        new_score =  ((params[:event][:end_time].to_time - params[:event][:start_time].to_time ) / 1.hour).round
        for i in @participations
          i.user.score = i.user.score + old_score - new_score
          i.user.save!
        end
        @event.start_time = params[:event][:start_time]
        @event.end_time = params[:event][:end_time]
        current_user.score = current_user.score + (new_score - old_score) * @participations.length
        current_user.save!
        end
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
