class AddReferencstoLogandAnswer < ActiveRecord::Migration[5.1]
  def change
      add_column :loghistories, :othertitle, :string
      add_reference :loghistories, :musicin, foreign_key: true
      add_reference :answers, :musicin, foreign_key: true
  end
end
