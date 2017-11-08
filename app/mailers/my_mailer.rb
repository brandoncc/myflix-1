class MyMailer < ActionMailer::Base
  def register_success_mail(user)
    @user = user
    mail(to: @user.email, subject: "Thanks for registering", from: "wxfwalter@gmail.com")
  end

  def send_password_reset(user)
    @user = user
    mail(to: user.email, subject: "Please reset your password", from: "wxfwalter@gmail.com")
  end
end