require 'spec_helper'

RSpec.describe VideosController, :type => :controller do
  describe "#show" do
    context "as authorized user" do
      before do
        session[:user_id] = Fabricate(:user)
      end

      it "sets @video" do
        video = Fabricate(:video)
        get :show, id: video.id
        expect(assigns(:video)).to eq video
      end
    end

    context "as a guest" do
      it "redirect to sign in path" do
        video = Fabricate(:video)
        get :show, id: video.id
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe "#search" do
    context "as authorized user" do
      before do
        session[:user_id] = Fabricate(:user)
      end

      it "responses successfully" do
        get :search, search_title: 'something'
        expect(response).to be_success
      end
    end

    context "as a guest" do
      it "redirects to sign in" do
        get :search
        expect(response).to redirect_to sign_in_path
      end
    end
  end
end