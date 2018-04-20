class CreateTeacherpositions < ActiveRecord::Migration[5.1]
  def change
    create_table :teacherpositions do |t|
      t.string :title
      
      t.timestamps
    end
  end
end
