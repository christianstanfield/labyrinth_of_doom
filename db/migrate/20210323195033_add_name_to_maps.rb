class AddNameToMaps < ActiveRecord::Migration[6.1]
  def change
    add_column :maps, :name, :string, null: false
  end
end
