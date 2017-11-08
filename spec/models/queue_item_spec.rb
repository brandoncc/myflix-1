require "spec_helper"

describe QueueItem, :type => :model do
  it { should belong_to :user}
  it { should belong_to :video}
  it { should validate_numericality_of(:position).only_integer}

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

    it "return nil when review for the video does not exist" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.rating).to eq nil
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

  describe "#update_rating" do
    let(:user) { Fabricate(:user) }
    let(:video) { Fabricate(:video) }
    let(:queue_item) { Fabricate(:queue_item, user: user, video: video) }

    context "review is not present" do
      it "creates a new review" do

        expect { queue_item.rating = 5 }.to change { Review.count }.by(1)
      end
    end

    context "review is present" do
      let!(:review) { Fabricate(:review, user: user, video: video) }

      it "changes the rating of the review" do
        queue_item.rating = 5
        expect(review.reload.rating).to eq 5
      end

      it "clears the rating of the review" do
        queue_item.rating = nil
        expect(review.reload.rating).to be_nil
      end
    end
  end
end