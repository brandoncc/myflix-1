require 'spec_helper'

feature "Admin access new view page and create videos" do
  scenario "Admin access new video page" do
    admin = Fabricate(:admin)
    sign_in(admin)
    visit new_admin_video_path
    expect_page_to_have('Add a New Video')
  end
end