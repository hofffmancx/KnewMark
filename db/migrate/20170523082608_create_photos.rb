class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.integer :knowledge_id, :index => true
      t.string :image
      t.timestamps
    end
  end
end
