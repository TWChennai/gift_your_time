class EventParticipationController < ApplicationController
  before_filter :authenticate_user!

  def new
    @event_participation = EventParticipation.new(event_participation_params)
    @event_participation.save!
    redirect_to event_path(@event_participation.event_id)
  end

  def destroy
    event_participation = EventParticipation.where(:user_id=>params[:event_participation][:user_id], :event_id =>params[:event_participation][:event_id]).limit(1)[0]
    event_participation.destroy
    redirect_to event_path(event_participation.event_id)
  end


  private
  def event_participation_params
    params.require(:event_participation).permit(:user_id, :event_id)
  end
end
