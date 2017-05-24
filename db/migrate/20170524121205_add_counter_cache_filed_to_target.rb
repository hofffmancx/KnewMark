class AddCounterCacheFiledToTarget < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :like_knowledges_count, :integer, default: 0
    add_column :users, :star_knowledges_count, :integer, default: 0
    add_column :users, :follow_knowledges_count, :integer, default: 0
    
    add_column :users, :followers_count, :integer, default: 0
    add_column :users, :following_count, :integer, default: 0

    add_column :knowledges, :likes_count, :integer, default: 0
    add_column :knowledges, :stars_count, :integer, default: 0
    add_column :knowledges, :follows_count, :integer, default: 0
  end
end
