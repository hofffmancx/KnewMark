class ChangeDescriptionOfQuestion < ActiveRecord::Migration[5.0]
  def change
    rename_column :questions, :description, :content
  end
end
