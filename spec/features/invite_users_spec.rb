require 'spec_helper'

feature "User invite another user" do
  scenario "invite an user", { js: true, vcr: true } do
    inviter = Fabricate(:user)
    invitation = Fabricate.attributes_for(:invitation)
    sign_in(inviter)

    invite_a_friend(invitation)
    friend_accepts(invitation)

    recipient = User.last
    recipient.password = "password"

    one_user_should_follow_the_other(recipient, inviter)
    one_user_should_follow_the_other(inviter, recipient)

    clear_email
  end
end

def invite_a_friend(invitation)
  visit new_invitation_path
  fill_in "Friend's Name", with: invitation[:recipient_name]
  fill_in "Friend's Email Address", with: invitation[:recipient_email]
  fill_in "Invitation Message", with: invitation[:message]
  click_button "Send Invitation"
  sign_out
end

def friend_accepts(invitation)
  open_email invitation[:recipient_email]
  current_email.click_link "Link to registering on myflix"
  fill_in "Password", with: "password"
  fill_in "Full Name", with: invitation[:recipient_name]
  fill_in "Credit Card Number", with: "4242424242424242"
  fill_in "Security Code", with: '123'
  select "1 - January", from: "date_month"
  select "2018", from: "date_year"
  click_button "Sign Up"
  expect_page_to_have('Sign in')
end

def one_user_should_follow_the_other(follower, leader)
  sign_in(follower)
  click_link "People"
  expect_page_to_have(leader.full_name)
  sign_out
end