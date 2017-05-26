class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.integer :knowledge_id
      t.integer :user_id
      t.string :title
      t.text :description
      t.timestamps
    end
  end
end
