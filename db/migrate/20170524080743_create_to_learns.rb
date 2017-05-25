class CreateToLearns < ActiveRecord::Migration[5.0]
  def change
    create_table :to_learns do |t|
      t.integer :user_id
      t.integer :knowledge_id
      t.timestamps
    end
  end
end
