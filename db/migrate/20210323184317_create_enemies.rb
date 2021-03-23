class CreateEnemies < ActiveRecord::Migration[6.1]
  def change
    create_table :enemies do |t|
      t.references :game, null: false, foreign_key: true
      t.integer :health, null: false
      t.integer :attack, null: false
      t.integer :defense, null: false
      t.integer :actions, null: false

      t.timestamps
    end
  end
end
