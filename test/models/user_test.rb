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
#  like_knowledges_count           :integer          default("0")
#  star_knowledges_count           :integer          default("0")
#  follow_knowledges_count         :integer          default("0")
#  followers_count                 :integer          default("0")
#  following_count                 :integer          default("0")
#  learn_knowledges_count          :integer          default("0")
#  buy_knowledges_count            :integer          default("0")
#  reviews_count                   :integer          default("0"), not null
#  discussions_count               :integer          default("0"), not null
#  comments_count                  :integer          default("0"), not null
#
# Indexes
#
#  index_users_on_activation_token      (activation_token)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_remember_me_token     (remember_me_token)
#  index_users_on_reset_password_token  (reset_password_token)
#

#  learn_knowledges_count          :integer          default("0")
#  buy_knowledges_count            :integer          default("0")

#
# Indexes
#
#  index_users_on_activation_token      (activation_token)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_remember_me_token     (remember_me_token)
#  index_users_on_reset_password_token  (reset_password_token)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
