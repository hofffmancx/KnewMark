class CreateKnowledges < ActiveRecord::Migration[5.0]
  def change
    create_table :knowledges do |t|
      t.string :title, :index => true
      t.string :subtitle
      t.text :description
      t.text :appropriate
      t.text :notice
      t.timestamps
    end
  end
end
