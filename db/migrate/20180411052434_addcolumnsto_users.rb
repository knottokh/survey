class AddcolumnstoUsers < ActiveRecord::Migration[5.1]
  def change
      add_column :users, :name, :string
      add_column :users, :lastname, :string
      add_column :users, :cardnumber, :string
      add_column :users, :position, :string
      add_column :users, :phone, :string
      add_column :users, :email, :string
  end
end
