require 'spec_helper'

RSpec.describe SessionsController, :type => :controller do
  describe "#new" do
    it "redirects to home path if logged in" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      get :new
      expect(response).to redirect_to home_path
    end

    it "render new if not logged in" do
      get :new
      expect(response).to be_success
    end
  end

  describe "Post #create" do
    context "with valid credentials" do
      let(:user) { Fabricate(:user) }
      before do
        post :create, email: user.email, password: user.password
      end

      it "puts the :user_id in session" do
        expect(session[:user_id]).to eq user.id
      end

      it "redirects to home path" do
        expect(response).to redirect_to home_path
      end

      it "sets the flash[notice]" do
        expect(flash['notice']).to_not be_blank
      end
    end

    context "with invalid credentials" do
      let(:user) { Fabricate(:user) }
      before do
        post :create, email: user.email, password: Faker::Lorem.characters(11)
      end

      it "does not put the :user_id in session" do
        expect(session[:user_id]).to be_nil
      end

      it "renders new" do
        expect(response).to render_template :new
      end

      it "sets the flash[notice]" do
        expect(flash['error']).to_not be_blank
      end
    end
  end

  describe "GET #destroy" do
    let(:user) { Fabricate(:user) }
    before do
      set_current_user(user)
      get :destroy
    end

    it "clears the session[:user_id]" do
      expect(session[:user_id]).to be_nil
    end

    it "redirects to the root path" do
      expect(response).to redirect_to root_path
    end

    it "sets flash notice" do
      expect(flash["notice"]).to_not be_blank
    end
  end
end