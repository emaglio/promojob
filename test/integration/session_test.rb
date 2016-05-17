require 'test_helper'

class SessionIntegrationTest < Trailblazer::Test::Integration

  let (:user) {User::Create.(user: FactoryGirl.attributes_for(:user)).model}

  
  it "fail_sign_in" do
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
    visit "sessions/new"

    page.must_have_css "#session_email"
    page.must_have_css "#session_password"
    page.must_have_button "Sign In"

    submit!(user.email, "Test1")

    # redirected to jobs_path
    page.must_have_content "All Jobs"
  end



end