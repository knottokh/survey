class CrateNewUsers < ActiveRecord::Migration[5.1]
  def change
     create_table :users do |t|
      t.string :school
      t.string :username
      t.string :password_digest

      t.timestamps
    end
  end
end
