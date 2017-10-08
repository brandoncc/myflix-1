Fabricator(:video) do
  title { Faker::Lorem.characters(10) }
  description { Faker::Lorem.characters(20) }
end

# create_table "videos", force: true do |t|
#     t.string   "title"
#     t.text     "description"
#     t.string   "small_cover_url"
#     t.string   "large_cover_url"
#     t.datetime "created_at"
#     t.datetime "updated_at"
#     t.integer  "category_id"
#   end