require "spec_helper"

RSpec.describe QueueItem, :type => :model do
  describe "#video_title" do
    it 'returns the video title' do
      video = Fabricate(:video, title: 'Monk')
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq video.title
    end
  end

  describe "#rating" do
    it "returns rating when review for the video exist" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      review = Fabricate(:review, user: user, video: video, rating: 10)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.rating).to eq 10
    end

    it "return 5 when review for the video does not exist" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.rating).to eq 5
    end
  end

  describe "#category_name" do
    it "returns category name" do
      category = Fabricate(:category)
      video = Fabricate(:video, title: 'Monk', category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category_name).to eq video.category.name
    end
  end

  describe "#category" do
    it "returns category of the video" do
      category = Fabricate(:category)
      video = Fabricate(:video, title: 'Monk', category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category).to eq video.category
    end
  end
end