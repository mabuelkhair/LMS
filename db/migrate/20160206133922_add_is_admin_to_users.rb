class AddIsAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_admin, :int,:default => 0
  end
end
