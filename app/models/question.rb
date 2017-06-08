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
#  anwsers_count :integer          default("0"), not null
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
end
