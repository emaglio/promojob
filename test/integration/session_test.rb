require 'test_helper'

class SessionIntegrationTest < Trailblazer::Test::Integration

  it "invalid log in (not existing)" do
    visit "sessions/new"

    submit!("","")

    page.must_have_css "#session_email"
    page.must_have_css "#session_password"
    page.must_have_button "Sign In"

    submit!("wrong@email.com", "wrong")

    page.must_have_css "#session_email"
    page.must_have_css "#session_password"
    page.must_have_button "Sign In"
  end

  it "success_sign_in" do
    op = User::Create.(user: FactoryGirl.attributes_for(:user))

    visit "sessions/new"

    page.must_have_css "#session_email"
    page.must_have_css "#session_password"
    page.must_have_button "Sign In"

    submit!(op.model.email, "Test1")

    # redirected to jobs_path
    page.must_have_content "All Jobs"
  end
end
 