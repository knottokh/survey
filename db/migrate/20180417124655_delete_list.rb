class DeleteList < ActiveRecord::Migration[5.1]
  def change
      drop_table :schools
      drop_table :tasks
      drop_table :todo_lists
      remove_column :questions, :isrequire 
  end
end
