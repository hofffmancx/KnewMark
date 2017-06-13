# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  knowledge_id  :integer
#  user_id       :integer
#  title         :string
#  description   :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  anwsers_count :integer          default(0), not null
#  friendly_id   :string
#
# Indexes
#
#  index_questions_on_friendly_id  (friendly_id) UNIQUE
#

class Question < ApplicationRecord
	include Friendly
	belongs_to :user, counter_cache: true
	belongs_to :knowledge, counter_cache: true
	has_many :anwsers, :dependent => :destroy
	after_create :create_event
	after_destroy :destroy_event

	def create_event
		EventService.new(self.knowledge, self, self.user, "提出了问题", self.knowledge).generate_event
	end

	def update_event!
		EventService.new(self.knowledge, self, self.user, "更新了问题", self.knowledge).generate_event
	end

	def destroy_event
		EventService.new(self.knowledge, self, self.user, "删除了问题", self.knowledge).generate_event
	end
end
