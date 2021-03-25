class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :owner, polymorphic: true, null: false
      t.string :name, null: false
      t.string :reference_id, null: false
      t.text :ability, null: false

      t.timestamps
    end
  end
end
