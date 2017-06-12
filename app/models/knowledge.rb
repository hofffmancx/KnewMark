# == Schema Information
#
# Table name: knowledges
#
#  id                :integer          not null, primary key
#  title             :string
#  subtitle          :string
#  description       :text
#  appropriate       :text
#  notice            :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  is_hidden         :boolean          default(TRUE)
#  status            :string           default("hidden")
#  category_id       :integer
#  likes_count       :integer          default(0)
#  marks_count       :integer          default(0)
#  follows_count     :integer          default(0)
#  wants_count       :integer          default(0)
#  haves_count       :integer          default(0)
#  reviews_count     :integer          default(0), not null
#  discussions_count :integer          default(0), not null
#  questions_count   :integer          default(0), not null
#  user_id           :integer
#  friendly_id       :string
#
# Indexes
#
#  index_knowledges_on_friendly_id  (friendly_id) UNIQUE
#  index_knowledges_on_title        (title)
#

#  wants_count  :integer          default("0")
#  haves_count    :integer          default("0")

#
# Indexes
#
#  index_knowledges_on_title  (title)
#

class Knowledge < ApplicationRecord
  include Friendly
  validates_presence_of :title, message: "标题不能为空"
  validates_presence_of :description, message: "请添加详情介绍"
  validates_presence_of :category_id, message: "分类不能为空"
  scope :recent, -> { order("created_at DESC") }

  has_many :knowledges_tags, class_name: "KnowledgesTags"
  has_many :tags, through: :knowledges_tags
  has_many :photos, :dependent => :destroy
  has_many :scores, :dependent => :destroy
  has_many :reviews, :dependent => :destroy
  has_many :discussions, :dependent => :destroy
  has_many :questions, :dependent => :destroy

  accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => :all_blank

  belongs_to :category
  belongs_to :user
  has_many :events

  def find_score(user)
    user && self.scores.where( :user_id => user.id ).first
  end

  def tags_string= one_tags
     self.tags.destroy_all

    one_tags.split(',').each do |tag|
      one_tag = Tag.find_by(title: tag)
      one_tag = Tag.new(title: tag) unless one_tag

      self.tags << one_tag
    end
  end


  def mark!(knowledge)
    EventService.new(self, self, knowledge.user, "收藏了知识", self).generate_event
  end

  def unmark!
    EventService.new(self, self, self.user, "取消收藏了知识", self).generate_event
  end

  def like!
    EventService.new(self, self, self.user, "喜欢了知识", self).generate_event
  end

  def unlike!
    EventService.new(self, self, self.user, "取消喜欢了知识", self).generate_event
  end

  def follow!
    EventService.new(self, self, self.user, "关注了知识", self).generate_event
  end

  def unfollow!
    EventService.new(self, self, self.user, "取消关注了知识", self).generate_event
  end

  def want!
    EventService.new(self, self, self.user, "想学了知识", self).generate_event
  end

  def unwant!
    EventService.new(self, self, self.user, "取消想学了知识", self).generate_event
  end

  def have!
    EventService.new(self, self, self.user, "学过知识", self).generate_event
  end

  def unhave!
    EventService.new(self, self, self.user, "取消学过了知识", self).generate_event
  end

  def average_score
    self.scores.average(:score)
  end

  def hide!
    self.status = "hidden"
    self.save
  end

  def reject!
    self.status = "failed"
    self.save
  end

  def publish!
    self.status = "published"
    self.save
  end

  def is_failed?
    self.status == "failed"
  end

end
