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
    expect_page_to_have("#{user2.full_name}'s video collections")

    click_link "Follow"
    expect_page_to_have("People I Follow")
    expect_page_to_have(user2.full_name)

    visit user_path(user2)
    expect_page_to_not_have('Follow')

    visit people_path
    click_unfollow(Relationship.first)
    expect_page_to_not_have(user2.full_name)
  end
end

def click_unfollow(relationship)
  find("a[href='/relationships/#{relationship.id}']").click
end