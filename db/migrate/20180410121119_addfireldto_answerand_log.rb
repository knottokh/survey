class AddfireldtoAnswerandLog < ActiveRecord::Migration[5.1]
  def change
      add_column :answers, :answer2, :string
      add_column :loghistories, :answer2, :string
  end
end
