# == Schema Information
#
# Table name: photos
#
#  id           :integer          not null, primary key
#  knowledge_id :integer
#  image        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_photos_on_knowledge_id  (knowledge_id)
#

require 'rails_helper'

RSpec.describe Photo, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
