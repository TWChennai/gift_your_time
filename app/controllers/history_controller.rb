class HistoryController < ApplicationController
  def index
    @organized_events = current_user.events
    @event_participations = EventParticipation.where("user_id = ?",current_user.id).pluck(:event_id)
    @participated_events = Event.where(id: @event_participations)
  end
end