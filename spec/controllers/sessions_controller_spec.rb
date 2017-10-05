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
    it "redirects to home path if log in successfully" do
      user = Fabricate(:user)
      post :create, email: user.email, password: user.password
      expect(response).to redirect_to home_path
    end

    it "renders new if failed to log in" do
      user = Fabricate(:user)
      post :create, email: user.email, password: Faker::Lorem.characters(11)
      expect(response).to render_template :new
    end
  end
end