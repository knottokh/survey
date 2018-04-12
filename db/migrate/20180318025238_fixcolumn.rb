class Fixcolumn < ActiveRecord::Migration[5.1]
  def change
    change_column :Users, :username, :string, null: false
      change_column :Users, :school, :string, null: false
  end
end
