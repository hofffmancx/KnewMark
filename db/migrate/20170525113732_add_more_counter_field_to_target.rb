class AddMoreCounterFieldToTarget < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :like_comments_count, :integer, default: 0
    add_column :users, :like_reviews_count, :integer, default: 0
    add_column :users, :like_discussions_count, :integer, default: 0

    add_column :comments, :likes_count, :integer, default: 0
    add_column :reviews, :likes_count, :integer, default: 0
    add_column :discussions, :likes_count, :integer, default: 0
  end
end
