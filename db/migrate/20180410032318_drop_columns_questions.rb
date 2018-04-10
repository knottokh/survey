class DropColumnsQuestions < ActiveRecord::Migration[5.1]
  def change
    remove_column :questions, :formtype 
  end
end
