class AddEventsCountToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :knowledges, :events_count, :integer, :default => 0
  Knowledge.pluck(:id).each do |i|
    Knowledge.reset_counters(i, :events)
  end 
  end
end
