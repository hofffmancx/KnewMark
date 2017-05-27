# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  email                           :string
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
#  like_knowledges_count           :integer          default("0")
#  star_knowledges_count           :integer          default("0")
#  follow_knowledges_count         :integer          default("0")
#  followers_count                 :integer          default("0")
#  following_count                 :integer          default("0")
#  want_knowledges_count           :integer          default("0")
#  have_knowledges_count           :integer          default("0")
#  reviews_count                   :integer          default("0"), not null
#  discussions_count               :integer          default("0"), not null
#  comments_count                  :integer          default("0"), not null
#  like_comments_count             :integer          default("0")
#  like_reviews_count              :integer          default("0")
#  like_discussions_count          :integer          default("0")
#  questions_count                 :integer          default("0"), not null
#  cellphone                       :string
#
# Indexes
#
#  index_users_on_activation_token      (activation_token)
#  index_users_on_cellphone             (cellphone)
#  index_users_on_email                 (email)
#  index_users_on_remember_me_token     (remember_me_token)
#  index_users_on_reset_password_token  (reset_password_token)
#

#  want_knowledges_count          :integer          default("0")
#  have_knowledges_count            :integer          default("0")

#
# Indexes
#
#  index_users_on_activation_token      (activation_token)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_remember_me_token     (remember_me_token)
#  index_users_on_reset_password_token  (reset_password_token)
#

class User < ApplicationRecord
  authenticates_with_sorcery!

  attr_accessor :password, :password_confirmation, :token
  CELLPHONE_RE = /\A(\+86|86)?1\d{10}\z/
  EMAIL_RE = /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/

  # validates_presence_of :email, message: "邮箱不能为空"
  # validates_format_of :email, message: "邮箱格式不合法", with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/,
  # if: proc { |user| !user.email.blank? }
  # validates :email, uniqueness: true

  validates_presence_of :password, message: "密码不能为空", if: :need_validate_password
  validates_presence_of :password_confirmation, message: "密码确认不能为空", if: :need_validate_password
  validates_confirmation_of :password, message: "密码不一致", if: :need_validate_password
  validates_length_of :password, minimum: 6, message: "密码最短为6位", if: :need_validate_password

  action_store :like, :knowledge, counter_cache: true, user_counter_cache: true
  action_store :like, :review, counter_cache: true, user_counter_cache: true
  action_store :like, :discussion, counter_cache: true, user_counter_cache: true
  action_store :like, :comment, counter_cache: true, user_counter_cache: true
  action_store :star, :knowledge, counter_cache: true, user_counter_cache: true
  action_store :follow, :knowledge, counter_cache: true, user_counter_cache: true
  action_store :follow, :user, counter_cache: 'followers_count', user_counter_cache: 'following_count'
  action_store :want, :knowledge, counter_cache: true, user_counter_cache: true
  action_store :have, :knowledge, counter_cache: true, user_counter_cache: true

  has_many :knowledges
  has_many :reviews, :dependent => :destroy
  has_many :discussions, :dependent => :destroy
  has_many :questions, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  def username
    self.email.blank? ? self.cellphone : self.email.split('@').first
  end

  def admin?
    is_admin
  end

  private

  def need_validate_password
    self.new_record? || (!self.password.nil? || !self.password_confirmation.nil?)
  end
  def validate_email_or_cellphone
    if [self.email, self.cellphone].all? { |attr| attr.nil? }
      self.errors.add :base, "邮箱和手机号其中之一不能为空"
      return false
    else
      if self.cellphone.nil?
        if self.email.blank?
          self.errors.add :email, "邮箱不能为空"
          return false
        else
          unless self.email =~ EMAIL_RE
            self.errors.add :email, "邮箱格式不正确"
            return false
          end
        end
      else
        unless self.cellphone =~ CELLPHONE_RE
          self.errors.add :cellphone, "手机号格式不正确"
          return false
        end

        unless VerifyToken.available.find_by(cellphone: self.cellphone, token: self.token)
          self.errors.add :cellphone, "手机验证码不正确或者已过期"
          return false
        end
      end
    end

    return true
  end
end
