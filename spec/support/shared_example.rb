RSpec.shared_examples "requires sign in" do
  it "redirects to sign in path" do
    action
    expect(response).to redirect_to sign_in_path
  end
end