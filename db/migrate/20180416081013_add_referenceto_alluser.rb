class AddReferencetoAlluser < ActiveRecord::Migration[5.1]
  def change
      add_reference :allusers, :school, foreign_key: true
      add_reference :allusers, :role, foreign_key: true
  end
end
