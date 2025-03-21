class AddColumnsToAdminUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :admin_users, :uid, :string
    add_column :admin_users, :provider, :string
    add_column :admin_users, :avatar_url, :string
  end
end
