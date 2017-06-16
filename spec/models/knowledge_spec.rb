# == Schema Information
#
# Table name: knowledges
#
#  id                :integer          not null, primary key
#  title             :string
#  subtitle          :string
#  description       :text
#  appropriate       :text
#  notice            :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  is_hidden         :boolean          default(TRUE)
#  status            :string           default("hidden")
#  category_id       :integer
#  likes_count       :integer          default(0)
#  marks_count       :integer          default(0)
#  follows_count     :integer          default(0)
#  wants_count       :integer          default(0)
#  haves_count       :integer          default(0)
#  reviews_count     :integer          default(0), not null
#  discussions_count :integer          default(0), not null
#  questions_count   :integer          default(0), not null
#  user_id           :integer
#  friendly_id       :string
#  events_count      :integer          default(0)
#
# Indexes
#
#  index_knowledges_on_friendly_id  (friendly_id) UNIQUE
#  index_knowledges_on_title        (title)
#

#  wants_count  :integer          default("0")
#  haves_count    :integer          default("0")

#
# Indexes
#
#  index_knowledges_on_title  (title)
#

require 'rails_helper'

RSpec.describe Knowledge, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
