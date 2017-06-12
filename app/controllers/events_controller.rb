class EventsController < ApplicationController
  def index
    @knowledge = Knowledge.find_by_friendly_id!(params[:knowledge_id])
    @events = @knowledge.events
    @group_events = @events.includes(:ownerable, :creator, :eventable).group_by{|e| e.created_at.to_date}
    @events_size = @events.size
  end

  protected

  def get_current_page
    @current_page = params[:current_page]
    if @current_page.blank?
      @current_page = 1
    end
  end
end
