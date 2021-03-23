class JoinCharactersToGame < ActiveRecord::Migration[6.1]
  def change
    add_reference :characters, :game, null: false, foreign_key: true
    remove_column :characters, :type
  end
end
