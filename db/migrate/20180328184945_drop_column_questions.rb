class DropColumnQuestions < ActiveRecord::Migration[5.1]
  def change
      remove_column :questions, :type
      add_column :questions, :qtype, :string
  end
end
