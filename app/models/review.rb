# == Schema Information
#
# Table name: reviews
#
#  id           :integer          not null, primary key
#  title        :string
#  content      :text
#  knowledge_id :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_reviews_on_knowledge_id  (knowledge_id)
#  index_reviews_on_user_id       (user_id)
#

class Review < ApplicationRecord

  validates_presence_of :title, message: "标题不能为空"
  validates_length_of :content, minimum: 300, too_short: "评测不应小于300字"

  belongs_to :knowledge
  belongs_to :user
  
end
