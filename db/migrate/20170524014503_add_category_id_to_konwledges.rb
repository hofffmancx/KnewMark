class AddCategoryIdToKonwledges < ActiveRecord::Migration[5.0]
  def change
    add_column :knowledges, :category_id, :integer, :index => true
  end
end
