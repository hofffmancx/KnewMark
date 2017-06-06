# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ApplicationRecord

  validates :title, uniqueness: { message: "标签已存在" }

  has_many :knowledges_tags, class_name: "KnowledgesTags"
  has_many :knowledges, through: :knowledges_tags

end
