class AddcolumntoQuestion < ActiveRecord::Migration[5.1]
  def change
      add_column :questions, :formtype, :integer
  end
end
