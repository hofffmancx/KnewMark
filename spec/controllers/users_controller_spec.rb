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
#  role                            :string           default("user")
#  like_knowledges_count           :integer          default(0)
#  mark_knowledges_count           :integer          default(0)
#  follow_knowledges_count         :integer          default(0)
#  followers_count                 :integer          default(0)
#  following_count                 :integer          default(0)
#  want_knowledges_count           :integer          default(0)
#  have_knowledges_count           :integer          default(0)
#  reviews_count                   :integer          default(0), not null
#  discussions_count               :integer          default(0), not null
#  comments_count                  :integer          default(0), not null
#  like_comments_count             :integer          default(0)
#  like_reviews_count              :integer          default(0)
#  like_discussions_count          :integer          default(0)
#  questions_count                 :integer          default(0), not null
#  anwsers_count                   :integer          default(0), not null
#  cellphone                       :string
#  avatar                          :string
#  username                        :string
#  friendly_id                     :string
#
# Indexes
#
#  index_users_on_activation_token      (activation_token)
#  index_users_on_cellphone             (cellphone)
#  index_users_on_email                 (email)
#  index_users_on_friendly_id           (friendly_id) UNIQUE
#  index_users_on_remember_me_token     (remember_me_token)
#  index_users_on_reset_password_token  (reset_password_token)
<<<<<<< HEAD
#  index_users_on_role                  (role)
=======
>>>>>>> 5b598fb562bfc9931e696cdf4f04e1e3cff51e1c
#

require 'rails_helper'

RSpec.describe UsersController, type: :controller do

end
