class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  scope :recent, -> { order("id DESC") }
end
