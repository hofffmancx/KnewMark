class User < ApplicationRecord
  authenticates_with_sorcery!

  attr_accessor :password, :password_confirmation

  validates_presence_of :email, message: "邮箱不能为空"
  validates_format_of :email, message: "邮箱格式不合法", with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/,
  if: proc { |user| !user.email.blank? }
  validates :email, uniqueness: true

  validates_presence_of :password, message: "密码不能为空", if: :need_validate_password
  validates_presence_of :password_confirmation, message: "密码确认不能为空", if: :need_validate_password
  validates_confirmation_of :password, message: "密码不一致", if: :need_validate_password
  validates_length_of :password, minimum: 6, message: "密码最短为6位", if: :need_validate_password

  has_many :to_learns
  has_many :wishlists, :through => :to_learns, :source => :knowledge

  has_many :owners
  has_many :knowledges, :through => :owners, :source => :knowledge

  def username
    self.email.split('@').first
  end

  def admin?
    is_admin
  end

  def is_liker_of?(knowledge)
    wishlists.include?(knowledge)
  end

  def is_buyer_of?(knowledge)
    knowledges.include?(knowledge)
  end

  def add!(knowledge)
    wishlists << knowledge
  end

  def remove!(knowledge)
    wishlists.delete(knowledge)
  end

  def buy!(knowledge)
    knowledges << knowledge
  end

  private

  def need_validate_password
    self.new_record? || (!self.password.nil? || !self.password_confirmation.nil?)
  end
end
