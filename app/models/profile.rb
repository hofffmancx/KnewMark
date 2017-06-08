# == Schema Information
#
# Table name: profiles
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  gender            :string
#  birthday          :date
#  location          :string
#  website           :string
#  self_introduction :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#

class Profile < ApplicationRecord
  GENDER = ["male", "female"]
  validates_inclusion_of :gender, :in => GENDER

  belongs_to :user
end
