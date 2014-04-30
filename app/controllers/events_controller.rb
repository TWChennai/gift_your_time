class EventsController < ApplicationController
  def index
  end

  def create
    event = Event.create!(name: params[:name], end_time: params[:end_time], start_time: params[:start_time], description: params[:description], user_id: params[:user_id], date: params[:date])
    event.save!
    head :ok
  end
end
