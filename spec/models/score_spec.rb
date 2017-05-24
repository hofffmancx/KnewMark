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

require 'rails_helper'

RSpec.describe Score, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
