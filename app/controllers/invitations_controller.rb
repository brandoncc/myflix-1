class InvitationsController < ApplicationController
  before_action :require_user

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params.merge!(inviter_id: current_user.id))

    if @invitation.save
      MyMailer.delay.send_invitation_mail(@invitation)
      flash[:notice] = "You have successfully sent an invitation email."
      redirect_to new_invitation_path
    else
      flash[:error] = "Please check your inputs."
      render :new
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:recipient_name, :recipient_email, :message)
  end
end