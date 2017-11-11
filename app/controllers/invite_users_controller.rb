class InviteUsersController < ApplicationController
  before_action :require_user

  def new
  end

  def create
    MyMailer.send_invitation_mail(invitation_params).deliver
    flash[:notice] = "You have successfully sent an invitation email."
    redirect_to home_path
  end

  private

  def invitation_params
    params.require(:invite_user).permit!
  end
end