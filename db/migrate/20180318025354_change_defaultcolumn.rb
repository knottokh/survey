class ChangeDefaultcolumn < ActiveRecord::Migration[5.1]
  def change
      change_column_default(:Users,:school, nil) 
      change_column_default(:Users, :username, nil) 
  end
end
