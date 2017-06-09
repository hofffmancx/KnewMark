# == Schema Information
#
# Table name: reviews
#
#  id             :integer          not null, primary key
#  title          :string
#  content        :text
#  knowledge_id   :integer
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  comments_count :integer          default(0), not null
#  likes_count    :integer          default(0)
#  friendly_id    :string
#
# Indexes
#
#  index_reviews_on_friendly_id   (friendly_id) UNIQUE
#  index_reviews_on_knowledge_id  (knowledge_id)
#  index_reviews_on_user_id       (user_id)
#

class Review < ApplicationRecord
  include Friendly
  validates_presence_of :title, message: "标题不能为空"
  validates_presence_of :content, message: "评测内容不能为空"
  validates_length_of :content, minimum: 300, too_short: "评测不应小于300字"

  belongs_to :knowledge, counter_cache: true
  belongs_to :user, counter_cache: true

  has_many :comments, :dependent => :destroy

end
