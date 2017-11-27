require 'spec_helper'

describe Admin::VideosController, :type => :controller do
  describe "GET #new" do
    it_behaves_like "requires sign in" do
      let(:action) { get :new }
    end

    it_behaves_like "requires admin sign in" do
      let(:action) { get :new }
    end
  end

  describe "POST #create" do
    it_behaves_like "requires sign in" do
      let(:action) { post :create }
    end
    it_behaves_like "requires admin sign in" do
      let(:action) { get :create }
    end

    context "with valid input" do
      before do
        set_current_admin
        video_attributes = Fabricate.attributes_for(:video)
        post :create, video: video_attributes
      end

      it "redirects to new video path" do
        expect(response).to redirect_to new_admin_video_path
      end

      it "creates a new video" do
        expect(Video.count).to eq(1)
      end
      it "sets flash notice message" do
        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid input" do
      before do
        set_current_admin
        video_attributes = Fabricate.attributes_for(:video, title: nil)
        post :create, video: video_attributes
      end

      it "render new video path template" do
        expect(response).to render_template :new
      end

      it "does not create a new video" do
        expect(Video.count).to eq(0)
      end
    end
  end
end