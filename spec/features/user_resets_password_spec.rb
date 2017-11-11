require 'spec_helper'

feature "user resets password" do
  scenario "user successfully resets the password" do
    user = Fabricate(:user, password: "old-password")
    visit sign_in_path
    click_link "Forgot Password?"
    fill_in "Email Address", with: user.email
    click_button "Send Email"
    open_email user.email
    current_email.click_link "Reset my password"
    fill_in "New Password", with: "new-password"
    click_button "Reset Password"
    fill_in "Email Address", with: user.email
    fill_in "Password", with: "new-password"
    click_button "Sign in"
    expect_page_to_have "Logged in successfully"
  end
end