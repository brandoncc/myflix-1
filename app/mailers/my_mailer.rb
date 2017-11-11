class MyMailer < ActionMailer::Base
  def register_success_mail(user)
    @user = user
    mail(to: @user.email, subject: "Thanks for registering", from: "walter@gmail.com")
  end

  def send_password_reset(user)
    @user = user
    mail(to: user.email, subject: "Please reset your password", from: "walter@gmail.com")
  end

  def send_invitation_mail(invitation)
    @invitation = invitation
    mail(to: invitation[:email], subject: "Friend invitation!", from: "walter@gmail.com")
  end
end