class CreateOwners < ActiveRecord::Migration[5.0]
  def change
    create_table :owners do |t|
      t.integer :user_id
      t.integer :knowledge_id
      t.timestamps
    end
  end
end
