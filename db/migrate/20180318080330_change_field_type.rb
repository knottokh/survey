class ChangeFieldType < ActiveRecord::Migration[5.1]
  def change
    change_column :Users, :email, :string, :null => true
  end
end
