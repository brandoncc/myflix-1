class UsersController < ApplicationController
  before_action :require_user, only: [:show]

  def new
    @user = User.new
  end

  def new_with_token
    invitation = Invitation.find_by(token: params[:token])

    if invitation
      @user = User.new(email: invitation.recipient_email)
      @invitation_token = invitation.token
      render :new
    else
      redirect_to expired_token_path
    end
  end

  def show
    @user = User.find_by(token: params[:id])
    @relationship = Relationship.find_by(follower:current_user, leader: @user)
  end

  def create
    @user = User.new(user_params)

    if @user.save
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

      MyMailer.delay.register_success_mail(@user)
      handle_invitation
      redirect_to sign_in_path
    else
      render :new
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
  end

  private

  def handle_invitation
    if params[:invitation_token].present?
      invitation = Invitation.find_by(token: params[:invitation_token])
      invitation.inviter.follow(@user)
      @user.follow(invitation.inviter)
      invitation.update_column(:token, nil)
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :full_name)
  end
end