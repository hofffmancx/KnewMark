class CreateAnwsers < ActiveRecord::Migration[5.0]
  def change
    create_table :anwsers do |t|
      t.integer :user_id
      t.integer :question_id
      t.text :content
      t.timestamps
    end

    add_column :users, :anwsers_count, :integer, default: 0, null: false
    add_column :questions, :anwsers_count, :integer, default: 0, null: false
  end
end
