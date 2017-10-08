require 'spec_helper'

RSpec.describe QueueItemsController, :type => :controller do
  describe "GET index" do
    context "as an authorized user" do
      let(:user) { Fabricate(:user) }
      before do
        session[:user_id] = user.id
      end

      it "sets @queue_items" do
        queue_item1 = Fabricate(:queue_item, user: user)
        queue_item2 = Fabricate(:queue_item, user: user)
        get :index
        expect(assigns(:queue_items)).to eq [queue_item1, queue_item2]
      end
    end

    context "as a guest" do
      it "redirects to home page" do
        get :index
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe "POST create" do
    context "as an authorized user" do
      let(:user) { Fabricate(:user) }
      before do
        session[:user_id] = user.id
      end

      it "redirects to my queue page" do
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(response).to redirect_to my_queue_path
      end

      it "creates a new queue item record" do
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(QueueItem.count).to eq 1
      end

      it "creates a new queue item associated with user" do
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(QueueItem.first.user).to eq user
      end

      it "creates a new queue item associated with video" do
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(QueueItem.first.video).to eq video
      end

      it "puts the new queue item at the bottom of queue" do
        video1 = Fabricate(:video)
        video2 = Fabricate(:video)
        Fabricate(:queue_item, video: video1, user: user)
        post :create, video_id: video2.id
        newly_created_item = QueueItem.find_by(user: user, video: video2)
        expect(newly_created_item.position).to eq 2
      end

      it "does not add new queue_item if one is exsited" do
        video1 = Fabricate(:video)
        Fabricate(:queue_item, video: video1, user: user)
        post :create, video_id: video1.id
        expect(user.queue_items.count).to eq 1
      end
    end

    context "as a guest" do
      it "redirects to sign in path" do
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe "POST destroy" do
    context "as an authorized user" do
      let(:user) { Fabricate(:user) }
      before do
        session[:user_id] = user.id
      end

      it "redirects to my queue" do
        video = Fabricate(:video)
        queue_item = Fabricate(:queue_item, user: user, video: video)
        delete :destroy, id: queue_item.id
        expect(response).to redirect_to my_queue_path
      end

      it "removes on item from queue" do
        video = Fabricate(:video)
        queue_item = Fabricate(:queue_item, user: user, video: video)
        delete :destroy, id: queue_item.id
        expect(QueueItem.count).to eq 0
      end

      it "does not act on other user's queue" do
        user1 = Fabricate(:user)
        video = Fabricate(:video)
        queue_item = Fabricate(:queue_item, user: user1, video: video)
        delete :destroy, id: queue_item.id
        expect(QueueItem.count).to eq 1
      end
    end

    context "as a guest" do
      it "redirects to sign in path" do
        user = Fabricate(:user)
        video = Fabricate(:video)
        queue_item = Fabricate(:queue_item, user: user, video: video)
        delete :destroy, id: queue_item.id
        expect(response).to redirect_to sign_in_path
      end
    end
  end
end