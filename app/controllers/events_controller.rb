class EventsController < ApplicationController
  def index
    @knowledge = Knowledge.find_by_friendly_id!(params[:knowledge_id])
    @events = @knowledge.events.recent
    @group_events = @events.includes(:ownerable, :creator, :eventable).group_by{|e| e.created_at.to_date}
    @events_size = @events.size
    session.delete(:days)
    session.delete(:owners)
  end
end
