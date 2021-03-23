class CreateCharacters < ActiveRecord::Migration[6.1]
  def change
    create_table :characters do |t|
      t.integer :health, null: false
      t.integer :attack, null: false
      t.integer :defense, null: false
      t.integer :actions, null: false
      t.string :type, null: false

      t.timestamps
    end
  end
end
