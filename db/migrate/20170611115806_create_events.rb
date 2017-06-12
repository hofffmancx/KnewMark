class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.integer :owner_id
      t.integer :creator_id
      t.integer :knowledge_id
      t.string :action
      t.integer :eventable_id
      t.string :eventable_type
      t.integer :ownerable_id
      t.string :ownerable_type
      t.timestamps
    end
    add_index :events, [:ownerable_id, :ownerable_type]
    add_index :events, [:eventable_id, :eventable_type]
    add_index :events, :team_id

  end
end
