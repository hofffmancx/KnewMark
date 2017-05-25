class AddCommentCounterToReviewAndUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :comments_count, :integer, default: 0, null: false
    add_column :reviews, :comments_count, :integer, default: 0, null: false
  end
end
