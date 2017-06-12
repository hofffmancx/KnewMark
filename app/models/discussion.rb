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
#  likes_count  :integer          default(0)
#  friendly_id  :string
#
# Indexes
#
#  index_discussions_on_friendly_id   (friendly_id) UNIQUE
#  index_discussions_on_knowledge_id  (knowledge_id)
#  index_discussions_on_user_id       (user_id)
#

class Discussion < ApplicationRecord
  include Friendly
  validates_presence_of :content, message: "讨论不能为空"
  validates_length_of :content, maximum: 300, too_long: "讨论不能超过300字"
  belongs_to :knowledge, counter_cache: true
  belongs_to :user, counter_cache: true
  after_create :create_event
  after_destroy :destroy_event
  def create_event
    EventService.new(self.knowledge, self, self.user, "发起了讨论", self.knowledge).generate_event
  end

  def update_event!
    EventService.new(self.knowledge, self, self.user, "更新了讨论", self.knowledge).generate_event
  end

  def destroy_event
    EventService.new(self.knowledge, self, self.user, "删除了讨论", self.knowledge).generate_event
  end

  def like!
    EventService.new(self.knowledge, self, self.user, "喜欢了讨论", self.knowledge).generate_event
  end

  def unlike!
    EventService.new(self.knowledge, self, self.user, "取消了喜欢讨论", self.knowledge).generate_event
  end
end
