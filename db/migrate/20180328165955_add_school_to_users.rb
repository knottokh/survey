class AddSchoolToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :school, foreign_key: true
  end
end
