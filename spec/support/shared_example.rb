RSpec.shared_examples "requires sign in" do
  it "redirects to sign in path" do
    action
    expect(response).to redirect_to sign_in_path
  end
end

RSpec.shared_examples "requires admin sign in" do
  before do
    set_current_user
    action
  end

  it "redirects regular user to home path" do
    expect(response).to redirect_to home_path
  end

  it "set flash error for regular user" do
    expect(flash[:error]).to be_present
  end
end

RSpec.shared_examples "tokenable" do
  it "generates a random token when the object is created" do
    expect(object.token).to be_present
  end
end

