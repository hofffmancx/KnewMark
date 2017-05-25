class AddCounterCatheToUserAndKnowledge < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :reviews_count, :integer, default: 0, null: false
    add_column :users, :discussions_count, :integer, default: 0, null: false
    add_column :knowledges, :reviews_count, :integer, default: 0, null: false
    add_column :knowledges, :discussions_count, :integer, default: 0, null: false
  end
end
