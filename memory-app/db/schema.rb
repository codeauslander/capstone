ActiveRecord::Schema.define(version: 20180218044038) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_images", force: :cascade do |t|
    t.integer "game_id"
    t.integer "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
  end

  create_table "games", force: :cascade do |t|
    t.boolean "done"
    t.integer "rows"
    t.integer "columns"
    t.integer "score"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "image_tags", force: :cascade do |t|
    t.integer "tag_id"
    t.integer "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.integer "age"
    t.boolean "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
