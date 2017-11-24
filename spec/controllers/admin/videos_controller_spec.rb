require 'spec_helper'

describe Admin::VideosController, :type => :controller do
  describe "new" do
    it_behaves_like "requires sign in" do
      let(:action) { get :new }
    end

    context "as a regular authorized user" do
      before do
        set_current_user
        get :new
      end

      it "redirects regular user to home path" do
        expect(response).to redirect_to home_path
      end

      it "set flash error for regular user" do
        expect(flash[:error]).to be_present
      end
    end
  end
end