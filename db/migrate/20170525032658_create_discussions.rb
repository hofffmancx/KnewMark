class CreateDiscussions < ActiveRecord::Migration[5.0]
  def change
    create_table :discussions do |t|
      t.text :content
      t.belongs_to :knowledge
      t.belongs_to :user
      t.timestamps
    end
  end
end
