# == Schema Information
#
# Table name: to_wants
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  knowledge_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Towant, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
