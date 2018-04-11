class AddRefToQuestion < ActiveRecord::Migration[5.1]
  def change
    
    remove_column :questions, :musicins_id
    add_reference :questions, :musicin, foreign_key: true
  end
end
