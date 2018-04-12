class DropTableMusicinss < ActiveRecord::Migration[5.1]
  def change
       drop_table :musicins
       remove_column :questions, :musicins_id 
  end
end
