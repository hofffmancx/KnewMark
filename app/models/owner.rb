# == Schema Information
#
# Table name: owners
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  knowledge_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Owner < ApplicationRecord
  belongs_to :user
  belongs_to :knowledge
end
