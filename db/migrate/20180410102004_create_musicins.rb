class CreateMusicins < ActiveRecord::Migration[5.1]
  def change
    create_table :musicins do |t|
      t.string :title
      t.integer :formtype
      t.timestamps
    end
    drop_table :musicinsses 
  end
end
