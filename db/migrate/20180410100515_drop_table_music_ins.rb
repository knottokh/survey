class DropTableMusicIns < ActiveRecord::Migration[5.1]
  def change
    drop_table :musicins
  end
end
