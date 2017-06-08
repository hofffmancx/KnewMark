# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  content     :text
#  user_id     :integer
#  review_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  likes_count :integer          default("0")
#  friendly_id :string
#
# Indexes
#
#  index_comments_on_friendly_id  (friendly_id) UNIQUE
#  index_comments_on_review_id    (review_id)
#  index_comments_on_user_id      (user_id)
#

class Comment < ApplicationRecord
  include Friendly
  validates_presence_of :content, message: "回复不能为空"
  validates_length_of :content, maximum: 1000, too_long: "不能超过1000字"

  belongs_to :user, counter_cache: true
  belongs_to :review, counter_cache: true

end
