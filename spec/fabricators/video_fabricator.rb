Fabricator(:video) do
  title { Faker::Lorem.characters(10) }
  description { Faker::Lorem.characters(20) }
  category
end
