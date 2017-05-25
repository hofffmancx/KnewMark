# == Schema Information
#
# Table name: knowledges
#
#  id            :integer          not null, primary key
#  title         :string
#  subtitle      :string
#  description   :text
#  appropriate   :text
#  notice        :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  is_hidden     :boolean          default("t")
#  status        :string           default("hidden")
#  category_id   :integer
#  likes_count   :integer          default("0")
#  stars_count   :integer          default("0")
#  follows_count :integer          default("0")
#  learns_count  :integer          default("0")
#  buys_count    :integer          default("0")
#
# Indexes
#
#  index_knowledges_on_title  (title)
#

#  learns_count  :integer          default("0")
#  buys_count    :integer          default("0")

#
# Indexes
#
#  index_knowledges_on_title  (title)
#

require 'rails_helper'

RSpec.describe Knowledge, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
