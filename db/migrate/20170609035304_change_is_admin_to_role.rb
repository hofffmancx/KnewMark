class ChangeIsAdminToRole < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :is_admin, :string, :default => "user"
  end

  add_index :users, [:is_admin]

  User.find_each do |user|
    unless user.is_admin
      user.update( :is_admin => "user")
    end
  end
end
