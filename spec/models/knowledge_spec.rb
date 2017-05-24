# == Schema Information
#
# Table name: knowledges
#
#  id          :integer          not null, primary key
#  title       :string
#  subtitle    :string
#  description :text
#  appropriate :text
#  notice      :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  is_hidden   :boolean          default("t")
#  status      :string           default("hidden")
#  category_id :integer
#

require 'rails_helper'

RSpec.describe Knowledge, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
