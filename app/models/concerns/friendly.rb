module Friendly

  extend ActiveSupport::Concern

  included do
    before_validation :generate_friendly_id, :on => :create
  end
  
   def to_param
     self.friendly_id
   end

   protected

   def generate_friendly_id
     self.friendly_id ||= SecureRandom.uuid
   end
end
