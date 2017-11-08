require 'spec_helper'

describe PasswordResetsController do
  describe "GET #show" do
    context "with valid reset token" do
      let(:user) { Fabricate(:user) }
      before do
        user.update_column("reset_token", SecureRandom.urlsafe_base64)
        get :show, id: user.reset_token
      end

      it "clear the reset token" do
        expect(user.reload.reset_token).to be_nil
      end
    end

    context "with invalid reset token" do
      it "redirects to expired page" do
        get :show, id: "fake-token"
        expect(response).to redirect_to expired_token_path
      end
    end
  end

  describe "POST #create" do
    context "with valid password" do
      let(:user) { Fabricate(:user) }
      before do
        post :create, password: "new-password", token: user.token
      end

      it "redirects to sign in path" do
        expect(response).to redirect_to sign_in_path
      end

      it "resets the password" do
        expect(user.reload.authenticate("new-password")).to be_true
      end

      it "sets the success flash message" do
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid password" do
      let(:user) { Fabricate(:user) }
      before do
        post :create, password: nil, token: user.token
      end

      it "renders password reset page" do
        expect(response).to render_template :expired_token
      end

      it "sets the error flash message" do
        expect(flash[:error]).to be_present
      end
    end
  end
end