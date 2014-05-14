class SearchController < ApplicationController
  def index
    query = query_string params[:query]

    get_results(query)
    render :layout => false
  end

  def get_results(query)
    unless query.length == 0

        event_results = search_events(query).slice(0, 50)

      events = []
      if event_results.present?
        events = event_results.map { |e| {:name => e.name, :event => e} }
      end

      @results = events.sort { |x, y| x[:name] <=> y[:name] }
    end
  end


  def all
    query = query_string params[:query]
    @results = get_results(query)
  end

  private

  def query_string query
    query == nil ? "" : query.strip
  end

  def search_events query
    Event.where(term_amongst(:name), :term => "%#{query}%")
  end

  def term_amongst *fields
    fields.map { |field| "#{field} ILIKE :term" }.join(" OR ")
  end
end
