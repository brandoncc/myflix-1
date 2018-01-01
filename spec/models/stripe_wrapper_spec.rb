require "spec_helper"

describe StripeWrapper do
  describe StripeWrapper::Charge do
    describe ".create" do
      let(:token) do
        Stripe::Token.create(
          :card => {
          :number => card_number,
          :exp_month => 12,
          :exp_year => 2018,
          :cvc => "314"
        }).id
      end

      let(:charge) { StripeWrapper::Charge.create(amount: 999, card: token) }

      context "with valid input", :vcr do
        let(:card_number) { "4242424242424242" }

        it "creates a new charge successfully" do
          expect(charge.response.amount).to eq 999
          expect(charge.response.currency).to eq 'usd'
        end

        it "charges card successfully" do
          expect(charge).to be_successful
        end
      end

      context "with invalid input", :vcr do
        let(:card_number) { "4000000000000002" }

        it "charges card successfully" do
          expect(charge).to_not be_successful
        end
        it "sets the error message" do
          expect(charge.error_message).to eq('Your card was declined.')
        end
      end
    end
  end
end
