class Knowledge < ApplicationRecord
  validates_presence_of :title, message: "标题不能为空"
  validates_presence_of :description, message: "请添加详情介绍", :length => { :maximum => 140, :tokenizer => lambda { |str| str.scan(/\w+/) }, :too_long  => "您已超出140 %{count} 字" }

  scope :recent, -> { order("created_at DESC") }

  has_many :photos, :dependent => :destroy
  accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => :all_blank

  def hide!
    self.is_hidden = true
    self.save
  end

  def publish!
    self.is_hidden = false
    self.save
  end

end
