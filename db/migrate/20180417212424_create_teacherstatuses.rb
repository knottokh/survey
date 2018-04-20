class CreateTeacherstatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :teacherstatuses do |t|
      t.string :title
      
      t.timestamps
    end
  end
end
