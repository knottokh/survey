class AddReferencQuestions < ActiveRecord::Migration[5.1]
  def change
      add_reference :questions, :musicins, foreign_key: true
  end
end
