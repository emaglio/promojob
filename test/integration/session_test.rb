require 'test_helper'

class SessionIntegrationTest < Trailblazer::Test::Integration

  it "invalid log in (not existing)" do
    visit "sessions/new"

    submit!("","")

    page.must_have_content "can't be blank"
    page.must_have_css "#session_email"
    page.must_have_css "#session_password"
    page.must_have_button "Sign In"

    submit!("wrong@email.com", "wrong")

    page.must_have_content "User not found"
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

    # test header
    page.must_have_content "Hi, #{op.model.firstname}"

    # redirected to jobs_path
    page.must_have_content "All Jobs"
  end

  it "success_sign_out" do
    op = User::Create.(user: FactoryGirl.attributes_for(:user))

    visit "sessions/new"

    submit!(op.model.email, "Test1")

    page.must_have_content "Hi, #{op.model.firstname}"

    click_link "Sign Out"

    page.wont_have_content "Hi, #{op.model.firstname}"    
    page.must_have_content "Sign In"
  end

end
 