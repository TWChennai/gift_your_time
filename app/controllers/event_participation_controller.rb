class EventParticipationController < ApplicationController
  before_filter :authenticate_user!

  def new
    @event_participation = EventParticipation.new(event_participation_params)
    event = @event_participation.event
    score_value = ((event.end_time - event.start_time) / 1.hour).round
    @event_participation.user.score = @event_participation.user.score - score_value
    @event_participation.user.save!
    @event_participation.save!
    event.user.score = event.user.score + score_value
    event.user.save!
    if params[:tag]=='search'
      redirect_to :back
    else
      redirect_to event_path(@event_participation.event_id)
    end
  end

  def destroy
    event_participation = EventParticipation.where(:user_id => params[:event_participation][:user_id], :event_id => params[:event_participation][:event_id]).limit(1)[0]
    event = event_participation.event
    score_value = ((event.end_time - event.start_time) / 1.hour).round
    event_participation.user.score = event_participation.user.score + score_value
    event_participation.user.save!
    event.user.score = event.user.score - ((event.end_time - event.start_time) / 1.hour).round
    event.user.save!

    event_participation.destroy
    if params[:tag]=='search'
      redirect_to :back
    else
      redirect_to event_path(event_participation.event_id)
    end
  end


  private
  def event_participation_params
    params.require(:event_participation).permit(:user_id, :event_id)
  end
end
