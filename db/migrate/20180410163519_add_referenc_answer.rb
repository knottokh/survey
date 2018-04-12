class AddReferencAnswer < ActiveRecord::Migration[5.1]
  def change
    remove_column :loghistories, :othertitle 
    add_column :loghistories, :othertitle, :string
    add_column :answers, :othertitle, :string
  end
end
