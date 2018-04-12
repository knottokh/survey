class AddRequiretoQuestion < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :isrequire, :boolean
  end
end
