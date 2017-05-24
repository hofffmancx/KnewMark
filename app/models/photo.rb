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

class Photo < ApplicationRecord
  belongs_to :knowledge
  mount_uploader :image, ImageUploader
end
