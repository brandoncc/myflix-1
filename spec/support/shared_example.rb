RSpec.shared_examples "requires sign in" do
  it "redirects to sign in path" do
    action
    expect(response).to redirect_to sign_in_path
  end
end

RSpec.shared_examples "tokenable" do
  it "generates a random token when the object is created" do
    expect(object.token).to be_present
  end
end

