class ChangeFieldUnique < ActiveRecord::Migration[5.1]
  def change
    change_column :Users, :username, :string, unique: true
    change_column :Users, :email, :string, unique: false
  end
end
