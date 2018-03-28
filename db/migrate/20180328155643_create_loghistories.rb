class CreateLoghistories < ActiveRecord::Migration[5.1]
  def change
    create_table :loghistories do |t|
      t.string :behavior
      t.string :answer
      
      t.timestamps
    end
  end
end
