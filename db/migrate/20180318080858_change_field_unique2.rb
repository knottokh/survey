class ChangeFieldUnique2 < ActiveRecord::Migration[5.1]
  def change
    remove_index :users, :email
    add_index :users, :username, :unique => true
  end
end
