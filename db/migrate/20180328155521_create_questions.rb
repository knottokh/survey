class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :type
      t.string :choice
      
      t.timestamps
    end
  end
end
