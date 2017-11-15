require 'spec_helper'

describe UsersController, :type => :controller do
  describe "GET new" do
    it "returns an instance of User" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "GET new_with_token" do
    it "returns an instance of User with email presented" do
      invitation = Fabricate(:invitation)
      get :new_with_token, token: invitation[:token]
      expect(assigns(:user).email).to eq invitation.recipient_email
    end

    it "redirects expired token page for invalid token" do
      get :new_with_token, token: 'random'
      expect(response).to redirect_to expired_token_path
    end
  end

  describe "GET show" do
    let(:user) { Fabricate(:user) }

    context "as an authorized user" do
      before do
        session[:user_id] = user.id
      end

      it "responses successfully" do
        get :show, id: user.id
        expect(response).to be_success
      end
    end

    context "as a guest" do
      it_behaves_like 'requires sign in' do
        let(:action) { get :show, id: user.id }
      end
    end
  end

  describe "POST create" do
    context "with valid input" do
      after do
        ActionMailer::Base.deliveries.clear
      end

      it "creates a new user" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(User.count).to eq 1
      end

      it "redirects to sign in path" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(response).to redirect_to sign_in_path
      end

      it "makes the inviter and the recipient follow each other" do
        inviter = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: inviter)
        post :create, user: Fabricate.attributes_for(:user), invitation_token: invitation.token
        expect(User.last.leaders).to eq [inviter]
        expect(User.last.followers).to eq [inviter]
      end

      it "clear the invitation token upon acceptance" do
        inviter = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: inviter)
        post :create, user: Fabricate.attributes_for(:user), invitation_token: invitation.token
        expect(invitation.reload.token).to be_nil
      end
    end

    context "with invalid input" do
      before do
        post :create, user: { email: Faker::Internet.email, password: Faker::Lorem.characters(10)}
      end

      it 'does not create a new user' do
        expect(User.count).to eq 0
      end
      it 'renders :new template' do
        expect(response).to render_template :new
      end
      it 'sets new @user' do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end

    context "sending email" do
      context "with valid input" do
        after do
          ActionMailer::Base.deliveries.clear
        end

        it "sends email" do
          user_attributes = Fabricate.attributes_for(:user)
          post :create, user: user_attributes
          expect(ActionMailer::Base.deliveries.last.to).to eq [user_attributes[:email]]
          expect(ActionMailer::Base.deliveries.last.body).to include user_attributes[:full_name]
        end
      end

      context "with invalid input" do
        after do
          ActionMailer::Base.deliveries.clear
        end

        it "does not send email" do
          post :create, user: Fabricate.attributes_for(:user, full_name: nil)
          expect(ActionMailer::Base.deliveries).to be_empty
        end
      end
    end
  end
end