class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id, :index => true
      t.string :gender
      t.date :birthday
      t.string :location
      t.string :website
      t.text :self_introduction
      t.timestamps
    end
  end
end
