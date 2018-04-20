class CreateTeacheruniversities < ActiveRecord::Migration[5.1]
  def change
    create_table :teacheruniversities do |t|
      t.string :title
      
      t.timestamps
    end
  end
end
