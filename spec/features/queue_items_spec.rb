require 'spec_helper'

feature "QueueItems" do
  scenario "user log in" do
    user = Fabricate(:user)
    category = Fabricate(:category)
    video = Fabricate(:video, category: category)

    visit root_path
    click_link 'Sign In'
    fill_in "Email Address", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"

    expect(page).to have_content user.full_name
    expect(page).to have_css('div.video')

    find('div.video').find('a').click
    expect(page).to have_content video.title

    click_on('+ My Queue')
    expect(page).to have_content 'List Order'
  end
end