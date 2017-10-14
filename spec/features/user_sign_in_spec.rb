require 'spec_helper'

feature "user sign in" do
  scenario "with valid email and password" do
    riddle_bear = Fabricate(:user, full_name: "Riddle Bear")
    sign_in(riddle_bear)
    expect(page).to have_content riddle_bear.full_name
  end
end