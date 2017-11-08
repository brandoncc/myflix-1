require "spec_helper"

describe ReviewsController, :type => :controller do
  describe "POST create" do
    context "with authorized user" do
      let(:user) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      before do
        set_current_user(user)
      end

      context "with valid input" do
        before do
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        end

        it "redirects to current video path" do
          expect(response).to redirect_to video
        end

        it "create a new review" do
          expect(Review.count).to eq (1)
        end

        it "sets notice" do
          expect(flash["notice"]).to_not be_blank
        end

        it "sets review associated with video" do
          expect(Review.first.video).to eq video
        end

        it "sets review associated with current user" do
          expect(Review.first.user).to eq user
        end
      end

      context "with invalid input" do
        it "does not create a review" do
          post :create, review: { rating: 5 }, video_id: video.id
          expect(Review.count).to eq (0)
        end

        it "renders video/show template" do
          post :create, review: { rating: 5 }, video_id: video.id
          expect(response).to render_template "videos/show"
        end

        it "sets @video" do
          post :create, review: { rating: 5 }, video_id: video.id
          expect(assigns(:video)).to eq video
        end

        it "sets @reviews" do
          review = Fabricate(:review, video: video, user: user)
          post :create, review: { rating: 5 }, video_id: video.id
          expect(assigns(:reviews)).to eq [review]
        end
      end
    end

    context "as a guest" do
      it_behaves_like "requires sign in" do
        let(:action) do
          video = Fabricate(:video)
          post :create, review: { rating: 5, content: Faker::Lorem.paragraph(2) }, video_id: video.id
        end
      end
    end
  end
end