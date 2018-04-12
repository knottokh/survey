class AddSchoolToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_reference :answers, :school, foreign_key: true
  end
end
