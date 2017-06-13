# == Schema Information
#
# Table name: events
#
#  id             :integer          not null, primary key
#  owner_id       :integer
#  creator_id     :integer
#  knowledge_id   :integer
#  action         :string
#  eventable_id   :integer
#  eventable_type :string
#  ownerable_id   :integer
#  ownerable_type :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_events_on_eventable_id_and_eventable_type  (eventable_id,eventable_type)
#  index_events_on_ownerable_id_and_ownerable_type  (ownerable_id,ownerable_type)
#  index_events_on_team_id                          ()
#

class Event < ApplicationRecord
  belongs_to :ownerable, polymorphic: true
  belongs_to :creator, class_name: "User"
  belongs_to :eventable, polymorphic: true
  belongs_to :knowledge, :counter_cache => true

  scope :recent, -> {order("created_at DESC")}
end
