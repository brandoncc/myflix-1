def set_current_user(user=nil)
  session[:user_id] = user.nil? ? Fabricate(:user).id : user.id
end

def sign_in(user=nil)
  user ||= Fabricate(:user)
  visit sign_in_path
  fill_in "Email Address", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def sign_out
  visit sign_out_path
end

def click_video(video)
  find("a[href='/videos/#{video.id}']").click
end

def expect_page_to_have(content)
  expect(page).to have_content content
end

def expect_page_to_not_have(content)
  expect(page).to have_no_content content
end