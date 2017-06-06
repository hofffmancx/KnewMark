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
#

class Anwser < ApplicationRecord
	belongs_to :question, counter_cache: true
	belongs_to :user, counter_cache: true
end
