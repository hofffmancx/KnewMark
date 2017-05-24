# == Schema Information
#
# Table name: scores
#
#  id           :integer          not null, primary key
#  knowledge_id :integer
#  score        :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_scores_on_knowledge_id  (knowledge_id)
#  index_scores_on_user_id       (user_id)
#

class Score < ApplicationRecord
  belongs_to :knowledge
  belongs_to :user
end
