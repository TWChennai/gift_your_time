class EventParticipationController < ApplicationController
  before_filter :authenticate_participant!, :only => [:create]
  def new
    @event_participation = EventParticipation.new(event_participation_params)
    @event_participation.save!
    redirect_to events_url
  end

  def destroy
    event_participation = EventParticipation.where("user_id="+ params[:event_participation][:user_id].to_s+ " AND event_id=" + params[:event_participation][:event_id].to_s)
    if event_participation.first.user_id == current_user.id
      event_participation.destroy_all
      redirect_to events_path
    end
  end


  private
  def event_participation_params
    params.require(:event_participation).permit(:user_id, :event_id)
  end
end
