require 'spec_helper'

describe ForgotPasswordsController do
  describe "POST #create" do
    context "with valid email" do
      let(:user) { Fabricate(:user) }
      it "redirects to confirm password reset page" do
        post :create, email: user.email
        expect(response).to redirect_to confirm_reset_path
      end

      it "set a password reset token" do
        post :create, email: user.email
        user.reload
        expect(user.reset_token).to be_present
      end

      it "sends an email" do
        post :create, email: user.email
        expect(ActionMailer::Base.deliveries.last.to).to eq [user.email]
      end
    end

    context "with invalid email" do
      before { post :create, email: 'anyone@example.com' }

      it "redirects to the forgot password page" do
        expect(response).to redirect_to forgot_password_path
      end

      it "sets the error message" do
        expect(flash[:error]).to be_present
      end
    end
  end
end
