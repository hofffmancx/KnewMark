class Score < ApplicationRecord
  belongs_to :knowledge
  belongs_to :user
end
