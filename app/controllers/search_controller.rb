class SearchController < ApplicationController
  def index
    @query = params[:query].strip
    @results = Event.where("name ilike ?", "%#{@query}%")
  end
end
