class Photo < ApplicationRecord
  belongs_to :knowledge
  mount_uploader :image, ImageUploader
end
