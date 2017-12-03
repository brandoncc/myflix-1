class ChargesController < ApplicationController
  def new
  end

  def create
    @amount = 990

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :currency    => 'usd'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
  end
end
