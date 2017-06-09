# == Schema Information
#
# Table name: categories
#
#  id                 :integer          not null, primary key
#  title              :string
#  weight             :integer          default(0)
#  knowledges_counter :integer          default(0)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  ancestry           :string
#
# Indexes
#
#  index_categories_on_ancestry  (ancestry)
#  index_categories_on_title     (title)
#

require 'rails_helper'

RSpec.describe Category, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
