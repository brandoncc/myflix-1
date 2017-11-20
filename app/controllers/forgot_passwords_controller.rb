class ForgotPasswordsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user
      user.update_column("reset_token", SecureRandom.urlsafe_base64)
      MyMailer.delay.send_password_reset(user)
      redirect_to confirm_reset_path
    else
      flash[:error] = "Sorry. Invalid email."
      redirect_to forgot_password_path
    end
  end
end