Fabricator(:queue_item) do
  video
  position { sequence(:pos) { |n| n + 1} }
end