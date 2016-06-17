require 'test_helper'

class UserIntegrationTest < Trailblazer::Test::Integration

  it "unsuccessfull sign_up" do
    visit "users/new"

    page.must_have_css "#user_firstname"
    page.must_have_css "#user_lastname"
    # page.must_have_css "#user_gender" TODO: how to test this?
    page.must_have_css "#user_email"
    page.must_have_css "#user_phone"
    page.must_have_css "#user_password"
    page.must_have_css "#user_confirm_password"
    page.must_have_button "Create User"

    #empty
    sign_up!("","","")
    page.must_have_content "can't be blank"
    
    #confirm_password false
    sign_up!("my@email.com","Test","Test1")
    page.must_have_content "Passwords don't match"

    #wrong password format
    sign_up!("my@email.com","test1","test1")
    page.must_have_content "must have at least: one number between 0 and 9; one Upper Case letter; one Lower Case letter"
      
  end

  it "successfully sign_up" do
    visit "users/new"

    sign_up!("my@email.com","Test1","Test1")

    page.must_have_content "All Jobs"   #TODO: change to Hi, name when we implement that
                                        #after creating a user i'm signed in as well
    page.must_have_content "MyName" #flash    
  end

  it "only user can edit user" do
    log_in_as_user #firstname= Ema email= my@email.com password= Test1

    page.must_have_link "Hi, Ema"
    click_link "Hi, Ema"
    page.must_have_link "Edit"
    click_link 'Edit'

    page.must_have_css "#user_firstname"
    page.must_have_css "#user_lastname"
    # page.must_have_css "#user_gender" TODO: how to test this?
    page.must_have_css "#user_email"
    page.must_have_css "#user_phone"
    page.must_have_css "#user_password"
    page.must_have_css "#user_confirm_password"

    user = User.find_by(email: "my@email.com")

    within("//form[@id='edit_user_#{user.id}']") do
      fill_in 'Firstname', with: "EmaNew"
      fill_in 'Password', with: "Test1"
      fill_in 'Confirm Password', with: "Test1"
    end 
    click_button "Update User"

    page.must_have_content "Your profile has been updated" #flash
    page.must_have_content "Hi, EmaNew"
  end

  it "successfully delete user" do
    log_in_as_user #firstname= Ema email= my@email.com password= Test1

    page.must_have_link "Hi, Ema"
    click_link "Hi, Ema"
    page.must_have_link "Edit"
    page.must_have_link "Delete"

    click_link "Delete"
    page.must_have_content "User deleted" #flash
    page.must_have_content "All Jobs"

    visit "sessions/new"

    submit!("my@email.com","Test1")
    page.must_have_content "User not found"
  end

end