# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_22_212139) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "character_positions", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.bigint "map_tile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["character_id"], name: "index_character_positions_on_character_id"
    t.index ["map_tile_id"], name: "index_character_positions_on_map_tile_id"
  end

  create_table "characters", force: :cascade do |t|
    t.integer "health", null: false
    t.integer "attack", null: false
    t.integer "defense", null: false
    t.integer "actions", null: false
    t.string "type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "map_tiles", force: :cascade do |t|
    t.string "terrain_type", null: false
    t.bigint "map_id", null: false
    t.integer "row", null: false
    t.integer "column", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["map_id"], name: "index_map_tiles_on_map_id"
  end

  create_table "maps", force: :cascade do |t|
    t.integer "length", null: false
    t.integer "height", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "character_positions", "characters"
  add_foreign_key "character_positions", "map_tiles"
  add_foreign_key "map_tiles", "maps"
end
