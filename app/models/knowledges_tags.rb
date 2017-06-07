# == Schema Information
#
# Table name: knowledges_tags
#
#  id           :integer          not null, primary key
#  knowledge_id :integer
#  tag_id       :integer
#

class KnowledgesTags < ApplicationRecord

  self.table_name = 'knowledges_tags'

  validates_uniqueness_of :knowledge_id, scope: [:tag_id]

  belongs_to :knowledge
  belongs_to :tag
end
