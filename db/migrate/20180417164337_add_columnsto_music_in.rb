class AddColumnstoMusicIn < ActiveRecord::Migration[5.1]
  def change
    add_column :musicins, :orderno, :integer
  end
end
