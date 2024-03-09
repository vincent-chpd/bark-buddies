class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  # def show
  # end

  # def create
  # end
  
end
