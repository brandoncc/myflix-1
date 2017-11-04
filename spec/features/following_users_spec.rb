require 'spec_helper'

feature "User follows a user and unfollow" do
  scenario "follow a user" do
    comedies = Fabricate(:category, name: "Comedies")
    video = Fabricate(:video, category: comedies)
    user1 = Fabricate(:user)
    user2 = Fabricate(:user)
    review = Fabricate(:review, video: video, user: user2)
    sign_in(user1)

    click_video(video)
    click_link(user2.full_name)
    expect(page).to have_content "#{user2.full_name}'s video collections"

    click_link "Follow"
    expect(page).to have_content "People I Follow"
    expect(page).to have_content user2.full_name

    visit user_path(user2)
    expect(page).to have_no_content 'Follow'

    visit people_path
    click_unfollow(Relationship.first)
    expect(page).to have_no_content user2.full_name
  end
end

def click_unfollow(relationship)
  find("a[href='/relationships/#{relationship.id}']").click
end