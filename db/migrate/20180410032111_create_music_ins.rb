class CreateMusicIns < ActiveRecord::Migration[5.1]
  def change
      create_table :music_ins do |t|
        t.string :title
        t.integer :formtype
      
        t.timestamps
    end
  end
end
