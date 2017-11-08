require 'spec_helper'

describe QueueItemsController, :type => :controller do
  describe "GET index" do
    context "as an authorized user" do
      let(:user) { Fabricate(:user) }
      before do
        set_current_user(user)
      end

      it "sets @queue_items" do
        queue_item1 = Fabricate(:queue_item, user: user)
        queue_item2 = Fabricate(:queue_item, user: user)
        get :index
        expect(assigns(:queue_items)).to eq [queue_item1, queue_item2]
      end
    end

    context "as a guest" do
      it_behaves_like "requires sign in" do
        let(:action) { get :index }
      end
    end
  end

  describe "POST create" do
    context "as an authorized user" do
      let(:user) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      before do
        set_current_user(user)
      end

      it "redirects to my queue page" do
        post :create, video_id: video.id
        expect(response).to redirect_to my_queue_path
      end

      it "creates a new queue item record" do
        post :create, video_id: video.id
        expect(QueueItem.count).to eq 1
      end

      it "creates a new queue item associated with user" do
        post :create, video_id: video.id
        expect(QueueItem.first.user).to eq user
      end

      it "creates a new queue item associated with video" do
        post :create, video_id: video.id
        expect(QueueItem.first.video).to eq video
      end

      it "puts the new queue item at the bottom of queue" do
        video2 = Fabricate(:video)
        Fabricate(:queue_item, video: video, user: user)
        post :create, video_id: video2.id
        newly_created_item = QueueItem.find_by(user: user, video: video2)
        expect(newly_created_item.position).to eq 2
      end

      it "does not add new queue_item if one is exsited" do
        Fabricate(:queue_item, video: video, user: user)
        post :create, video_id: video.id
        expect(user.queue_items.count).to eq 1
      end
    end

    context "as a guest" do
      it_behaves_like "requires sign in" do
        let(:action) { post :create, video_id: Fabricate(:video).id }
      end
    end
  end

  describe "POST destroy" do
    context "as an authorized user" do
      let(:user) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:queue_item) { Fabricate(:queue_item, user: user, video: video) }

      before do
        set_current_user(user)
      end

      it "redirects to my queue" do
        delete :destroy, id: queue_item.id
        expect(response).to redirect_to my_queue_path
      end

      it "removes on item from queue" do
        delete :destroy, id: queue_item.id
        expect(QueueItem.count).to eq 0
      end

      it "does not act on other user's queue" do
        user1 = Fabricate(:user)
        queue_item = Fabricate(:queue_item, user: user1, video: video)
        delete :destroy, id: queue_item.id
        expect(QueueItem.count).to eq 1
      end
    end

    context "as a guest" do
      it_behaves_like "requires sign in" do
        let(:action) do
          queue_item = Fabricate(:queue_item, user: Fabricate(:user), video: Fabricate(:video))
          delete :destroy, id: queue_item.id
        end
      end
    end
  end

  describe "POST update" do
    context "as an authorized user" do
      let(:user) { Fabricate(:user) }
      let(:queue_item1) { Fabricate(:queue_item, user: user) }
      let(:queue_item2) { Fabricate(:queue_item, user: user) }

      before do
        set_current_user(user)
      end

      context "with valid input" do
        it "redirects to my queue path" do
          post :update, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
          expect(user.queue_items).to eq [queue_item2, queue_item1]
        end

        it "reorders the queue items" do
          post :update, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
          expect(user.queue_items).to eq [queue_item2, queue_item1]
        end

        it "normalizes the position numbers" do
          post :update, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
          expect(user.queue_items.last).to eq queue_item1.reload
        end
      end

      context "with invalid input" do
        it "redirects my queue path" do
          post :update, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2.5}]
          expect(response).to redirect_to my_queue_path
        end

        it "sets flash['error']" do
          post :update, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2.5}]
          expect(flash['error']).to be_present
        end

        it "does not reorder" do
          post :update, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2.5}]
          expect(user.queue_items.reload.last).to eq queue_item2
        end

        it "does not update valid input" do
          post :update, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1.5}]
          expect(user.queue_items.reload.first).to_not eq 2
        end

        it "updates rating" do
          video = Fabricate(:video)
          queue_item = Fabricate(:queue_item, user: user, video: video)
          review = Fabricate(:review, user: user, video: video)

          post :update, queue_items: [{id: queue_item.id, position: 2.5, rating: 5}]
          expect(user.queue_items.first.rating).to eq 5
        end
      end

      it 'does not update queue item of other users' do
        other_user = Fabricate(:user)
        set_current_user(other_user)

        post :update, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2}]
        expect(user.queue_items.reload.last).to eq queue_item2
      end
    end

    context "as a guest" do
      it_behaves_like "requires sign in" do
        let(:action) { post :update }
      end
    end
  end
end