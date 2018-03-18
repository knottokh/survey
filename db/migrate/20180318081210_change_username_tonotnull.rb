class ChangeUsernameTonotnull < ActiveRecord::Migration[5.1]
  def change
      change_column :Users, :username, :string,null: false, unique: true
  end
end
