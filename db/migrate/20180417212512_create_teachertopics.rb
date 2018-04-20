class CreateTeachertopics < ActiveRecord::Migration[5.1]
  def change
    create_table :teachertopics do |t|
      t.string :title
      
      t.timestamps
    end
  end
end
