# == Schema Information
#
# Table name: photos
#
#  id           :integer          not null, primary key
#  knowledge_id :integer
#  image        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#
# Indexes
#
#  index_photos_on_knowledge_id  (knowledge_id)
#

class Photo < ApplicationRecord
  belongs_to :knowledge
  belongs_to :user
  validates :image, presence: true
  mount_uploader :image, ImageUploader
end
