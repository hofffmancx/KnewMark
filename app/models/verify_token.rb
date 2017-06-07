# == Schema Information
#
# Table name: verify_tokens
#
#  id         :integer          not null, primary key
#  token      :string
#  cellphone  :string
#  expired_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_verify_tokens_on_cellphone_and_token  (cellphone,token)
#

class VerifyToken < ApplicationRecord

  validates_presence_of :token
  validates_presence_of :cellphone

  scope :available, -> { where("expired_at > :time", time: Time.now) }

  def self.upsert cellphone, token
    cond = { cellphone: cellphone }
    record = self.find_by(cond)
    unless record
      record = self.create cond.merge(token: token, expired_at: Time.now + 10.minutes)
    else
      record.update_attributes token: token, expired_at: Time.now + 10.minutes
    end

    record
  end
end
