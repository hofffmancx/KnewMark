class RenameColumnToKnowledges < ActiveRecord::Migration[5.0]
  def change
  	rename_column :knowledges, :learns_count, :wants_count
  	rename_column :knowledges, :buys_count, :haves_count
  	rename_column :users, :learn_knowledges_count, :want_knowledges_count
  	rename_column :users, :buy_knowledges_count, :have_knowledges_count
  end
end
