class RenameIsAdminToRole < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :is_admin, :role
  end
end
