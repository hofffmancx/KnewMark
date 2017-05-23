class AddIsHiddenToKnowledges < ActiveRecord::Migration[5.0]
  def change
    add_column :knowledges, :is_hidden, :boolean, default: true
  end
end
