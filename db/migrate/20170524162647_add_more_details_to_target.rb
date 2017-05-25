class AddMoreDetailsToTarget < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :learn_knowledges_count, :integer, default: 0
    add_column :users, :buy_knowledges_count, :integer, default: 0

    add_column :knowledges, :learns_count, :integer, default: 0
    add_column :knowledges, :buys_count, :integer, default: 0
  end
end
