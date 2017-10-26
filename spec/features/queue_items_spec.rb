require 'spec_helper'

feature "User interacts with queue" do
  scenario "user adds and reorders videos in the queue" do
    riddle = Fabricate(:user, full_name: "Riddle Bear")
    comedies = Fabricate(:category, name: "Comedies")
    monk = Fabricate(:video, category: comedies, title: 'Monk')
    south_park = Fabricate(:video, category: comedies, title: 'South Park')
    futurama = Fabricate(:video, category: comedies, title: 'Futurama')

    sign_in(riddle)

    click_video(monk)
    expect(page).to have_content monk.title

    click_link "+ My Queue"
    expect(page).to have_content "Your list is queued up!"

    visit video_path(monk)
    expect(page).to_not have_content "+ My Queue"

    visit home_path
    click_video(south_park)
    click_link "+ My Queue"

    visit home_path
    click_video(futurama)
    click_link "+ My Queue"

    set_position(monk, 2)
    set_position(south_park, 3)
    set_position(futurama, 1)

    click_button 'Update Instant Queue'

    expect(return_position(monk)).to eq '2'
    expect(return_position(south_park)).to eq '3'
    expect(return_position(futurama)).to eq '1'
  end
end

def click_video(video)
  find("a[href='/videos/#{video.id}']").click
end

def set_position(video, pos)
  find_position_input(video).set(pos)
end

def return_position(video)
  find_position_input(video).value
end

def find_position_input(video)
  find(:xpath, "//tr[contains(.//a/text(),'#{video.title}')]//input[@name='queue_items[][position]']")
end