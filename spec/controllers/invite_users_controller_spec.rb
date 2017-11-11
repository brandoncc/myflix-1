require 'spec_helper'

describe InviteUsersController do
  describe "GET #new" do
    context "as an authorized user" do
      it "responses successfully" do
        set_current_user
        get :new
        expect(response).to be_success
      end
    end

    context "as a guest" do
      it_behaves_like "requires sign in" do
        let(:action) { get :new }
      end
    end
  end

  describe "POST #create" do
    context "as an authorized user" do
      let(:invitor) { Fabricate(:user) }
      let(:invitation) do
        {
          name: Faker::Name.first_name,
          email: Faker::Internet.email,
          message: Faker::Lorem.characters(10),
          invitor: invitor.token
        }
      end

      before do
        set_current_user(invitor)
        post :create, invite_user: invitation
      end

      it "redirects to home path" do
        expect(response).to redirect_to home_path
      end

      it "sends an email" do
        expect(ActionMailer::Base.deliveries.last.to).to eq [invitation[:email]]
      end

      it "sets the notice flash message" do
        expect(flash[:notice]).to be_present
      end
    end

    context "as a guest" do
      it_behaves_like "requires sign in" do
        let(:action) { get :new }
      end
    end
  end
end
