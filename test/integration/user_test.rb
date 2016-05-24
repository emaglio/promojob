require 'test_helper'

class UserIntegrationTest < Trailblazer::Test::Integration

  it "unsuccessfull sign_up" do
    visit "users/new"

    page.must_have_css "#user_firstname"
    page.must_have_css "#user_lastname"
    page.must_have_css "#user_gender"
    page.must_have_css "#user_email"
    page.must_have_css "#user_phone"
    page.must_have_css "#user_password"
    page.must_have_css "#user_confirm_password"
    page.must_have_button "Create User"

    #empty
    sign_up!("","","")
    page.must_have_content "Emailcan't be blank"
    page.must_have_content "Passwordcan't be blank"
    page.must_have_content "Confirm_passwordcan't be blank" #not sure

    #confirm_password false
    sign_up!("my@email.com","Test","Test1")
    page.must_have_content "??" #error

    #wrong password format
    sign_up!("my@email.com","test1","test1")
    page.must_have_content "??" #error
      
  end

  it "successfully sign_up" do
    visit "users/new"

    sign_up!("my@email.com","Test1","Test1")

    #how do I test that I have created this user?
    #check which page is shown after clicking on Create User

  end

end