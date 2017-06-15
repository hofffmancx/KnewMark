# == Schema Information
#
# Table name: anwsers
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  question_id :integer
#  content     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  friendly_id :string
#
# Indexes
#
#  index_anwsers_on_friendly_id  (friendly_id) UNIQUE
#

class Anwser < ApplicationRecord
  include Friendly
	include PublicActivity::Common
  # tracked owner: ->(controller, model) { controller && controller.current_user }

	validates_presence_of :content

	belongs_to :question, counter_cache: true
	belongs_to :user, counter_cache: true
  # after_create :create_event
  # after_destroy :destroy_event
  # def create_event
  #   EventService.new(self.question, self, self.user, "回答了问题", self.question.knowledge).generate_event
  # end
  #
  # def update_event!
  #   EventService.new(self.question, self, self.user, "更新了回答", self.question.knowledge).generate_event
  # end
  #
  # def destroy_event
  #   EventService.new(self.question, self, self.user, "删除了回答", self.question.knowledge).generate_event
  # end
end
