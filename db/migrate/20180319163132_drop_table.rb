class DropTable < ActiveRecord::Migration[5.1]
  def change
      drop_table :users
      drop_table :admins
  end
end
