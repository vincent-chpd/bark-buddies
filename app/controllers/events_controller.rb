class EventsController < ApplicationController
  def index
    if params[:query].present?
      @events = Event.search_by_location(params[:query])
    else
      @events = Event.all.all.order(:date)
    end
  end
end
