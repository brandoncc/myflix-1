class MyMailer < ActionMailer::Base
  # before_action :check_before_sending

  def register_success_mail(user)
    @user = user
    mail(to: user.email, subject: "Thanks for registering", from: "walter@gmail.com")
  end

  def send_password_reset(user)
    @user = user
    mail(to: user.email, subject: "Please reset your password", from: "walter@gmail.com")
  end

  def send_invitation_mail(invitation)
    @invitation = invitation
    mail(to: invitation[:recipient_email], subject: "An invitation to myflix!", from: "walter@gmail.com")
  end

  private

  def check_before_sending
    p Rails.env.staging?
    if Rails.env.staging?
      mail.perform_deliveries = false
    end
  end
end