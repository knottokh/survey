class AddUserToLoghistories < ActiveRecord::Migration[5.1]
  def change
    add_reference :loghistories, :user, foreign_key: true
    add_reference :loghistories, :question, foreign_key: true
  end
end
