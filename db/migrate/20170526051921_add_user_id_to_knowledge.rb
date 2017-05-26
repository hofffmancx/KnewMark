class AddUserIdToKnowledge < ActiveRecord::Migration[5.0]
  def change
    add_column :knowledges, :user_id, :integer, :index => true
  end
end
