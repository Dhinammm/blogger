class DropColumn < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :password_digest
    rename_column :users, :email_address, :email
  end
end
