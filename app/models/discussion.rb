# == Schema Information
#
# Table name: discussions
#
#  id           :integer          not null, primary key
#  content      :text
#  knowledge_id :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  likes_count  :integer          default("0")
#
# Indexes
#
#  index_discussions_on_knowledge_id  (knowledge_id)
#  index_discussions_on_user_id       (user_id)
#

class Discussion < ApplicationRecord

  validates_presence_of :content, message: "讨论不能为空"
  validates_length_of :content, maximum: 300, too_long: "讨论不能超过300字"
  belongs_to :knowledge, counter_cache: true
  belongs_to :user, counter_cache: true
end
