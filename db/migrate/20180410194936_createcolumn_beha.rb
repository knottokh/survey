class CreatecolumnBeha < ActiveRecord::Migration[5.1]
  def change
    add_column :logmusicteachers, :behavior, :string
  end
end
