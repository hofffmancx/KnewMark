class AddMoreDetailsToTarget < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :want_knowledges_count, :integer, default: 0
    add_column :users, :have_knowledges_count, :integer, default: 0

    add_column :knowledges, :wants_count, :integer, default: 0
    add_column :knowledges, :haves_count, :integer, default: 0
  end
end
