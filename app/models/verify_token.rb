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
end
