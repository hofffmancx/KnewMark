# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  email                           :string           not null
#  crypted_password                :string
#  salt                            :string
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  remember_me_token               :string
#  remember_me_token_expires_at    :datetime
#  reset_password_token            :string
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  activation_state                :string
#  activation_token                :string
#  activation_token_expires_at     :datetime
#  is_admin                        :boolean          default("f")
#

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

  def username
    self.email.split('@').first
  end

  def admin?
    is_admin
  end

  private
  def need_validate_password
    self.new_record? || (!self.password.nil? || !self.password_confirmation.nil?)
  end
end
