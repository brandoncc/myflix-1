Fabricator(:review) do
  rating { (1..4).to_a.sample }
  content { Faker::Lorem.paragraph(3) }
end