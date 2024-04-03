class EventsController < ApplicationController
  def index
    if params[:query].present?
      @events = Event.search_by_title(params[:query])
    else
      @events = Event.includes(photo_attachment: :blob).all.order(:date)
    end
  end
end
