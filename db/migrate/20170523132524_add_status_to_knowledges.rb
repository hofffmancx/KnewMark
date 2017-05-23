class AddStatusToKnowledges < ActiveRecord::Migration[5.0]
  def change
    add_column :knowledges, :status, :string, default: "hidden", :index => true
  end
end
