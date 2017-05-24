class Knowledge < ApplicationRecord
  validates_presence_of :title, message: "标题不能为空"
  validates_presence_of :description, message: "请添加详情介绍"

  scope :recent, -> { order("created_at DESC") }

  has_many :photos, :dependent => :destroy
  accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => :all_blank

  has_many :to_learns
  has_many :likers, :through => :to_learns, :source => :user

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
end
