require 'spec_helper'

feature "User registers", { js: true, vcr: true } do
  background do
    visit register_path
  end

  scenario "valid personal info and invalid card" do
    fill_in_valid_personal_info
    fill_in_invalid_card
    click_button "Sign Up"
    expect_page_to_have('The card number is not a valid credit card number.')
  end

  scenario "valid personal info and declined card" do
    fill_in_valid_personal_info
    fill_in_declined_card
    click_button "Sign Up"
    expect_page_to_have('Your card was declined.')
  end

  scenario "invalid personal info and valid card" do
    fill_in_invalid_personal_info
    fill_in_valid_card
    click_button "Sign Up"
    expect_page_to_have("Invalid user information. Please check the errors below.")
  end

  scenario "invalid personal info and invalid card" do
    fill_in_invalid_personal_info
    fill_in_invalid_card
    click_button "Sign Up"
    expect_page_to_have('The card number is not a valid credit card number.')
  end

  scenario "invalid personal info and declined card" do
    fill_in_invalid_personal_info
    fill_in_declined_card
    click_button "Sign Up"
    expect_page_to_have("Invalid user information. Please check the errors below.")
  end

  def fill_in_valid_personal_info
    fill_in "Email Address", with: "john@example.com"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "john smith"
  end

  def fill_in_invalid_personal_info
    fill_in "Email Address", with: "john@example.com"
  end

  def fill_in_valid_card
    fill_in "Credit Card Number", with: "4242424242424242"
    fill_in "Security Code", with: '123'
    select "1 - January", from: "date_month"
    select "2018", from: "date_year"
  end

  def fill_in_invalid_card
    fill_in "Credit Card Number", with: "123"
    fill_in "Security Code", with: '123'
    select "1 - January", from: "date_month"
    select "2018", from: "date_year"
  end

  def fill_in_declined_card
    fill_in "Credit Card Number", with: "4000000000000002"
    fill_in "Security Code", with: '123'
    select "1 - January", from: "date_month"
    select "2018", from: "date_year"
  end
end