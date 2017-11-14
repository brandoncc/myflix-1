require 'spec_helper'

describe InvitationsController do
  describe "GET #new" do
    context "as an authorized user" do
      before do
        set_current_user
        get :new
      end

      it "sets @invitation to a new invitation" do
        expect(assigns(:invitation)).to be_new_record
        expect(assigns(:invitation)).to be_instance_of Invitation
      end

      it "responses successfully" do
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
      let(:invitation_attibutes) { Fabricate.attributes_for(:invitation) }

      before { set_current_user }
      after { ActionMailer::Base.deliveries.clear }

      context "with valid input" do
        before { post :create, invitation: invitation_attibutes }

        it "redirects to new invitation page" do
          expect(response).to redirect_to new_invitation_path
        end

        it "creates a new invitation" do
          expect(Invitation.count).to eq(1)
        end

        it "sends an email to the recipient" do
          expect(ActionMailer::Base.deliveries.last.to).to eq [invitation_attibutes[:recipient_email]]
        end

        it "sets notice flash message" do
          expect(flash[:notice]).to be_present
        end
      end

      context "with invalid input" do
        before do
          invitation_attibutes[:recipient_email] = nil
          post :create, invitation: invitation_attibutes
        end

        it "renders new page" do
          expect(response).to render_template :new
        end

        it "does not create an invitation" do
          expect(Invitation.count).to eq(0)
        end

        it "does not sent an email" do
          expect(ActionMailer::Base.deliveries).to be_empty
        end

        it "sets error flash message" do
          expect(flash[:error]).to be_present
        end
      end
    end

    context "as a guest" do
      it_behaves_like "requires sign in" do
        let(:action) { get :new }
      end
    end
  end
end
