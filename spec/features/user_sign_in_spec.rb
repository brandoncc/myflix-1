require 'spec_helper'

feature "user sign in" do
  scenario "with valid email and password" do
    riddle_bear = Fabricate(:user, full_name: "Riddle Bear")
    sign_in(riddle_bear)
    expect_page_to_have riddle_bear.full_name
  end
end