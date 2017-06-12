class EventsController < ApplicationController
  def index
    @knowledge = Knowledge.find_by_friendly_id!(params[:id])
    @events = @knowledge.events.all
  end
end
