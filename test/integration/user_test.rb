require 'test_helper'

class UserIntegrationTest < Trailblazer::Test::Integration

  it "unsuccessfull sign_up" do
    visit "users/new"

    page.must_have_css "#user_firstname"
    page.must_have_css "#user_lastname"
    page.must_have_selector ("#user_gender")
    page.must_have_css "#user_email"
    page.must_have_css "#user_phone"
    page.must_have_css "#user_password"
    page.must_have_css "#user_confirm_password"
    page.must_have_button "Create User"

    #empty
    sign_up!("","","")
    page.must_have_content "can't be blank"
    page.current_path.must_equal "/users"
    
    #confirm_password false
    sign_up!("my@email.com","Test","Test1")
    page.must_have_content "Passwords don't match"
    page.current_path.must_equal "/users"

    #wrong password format
    sign_up!("my@email.com","test1","test1")
    page.must_have_content "must have at least: one number between 0 and 9; one Upper Case letter; one Lower Case letter"
    page.current_path.must_equal "/users"
  end

  it "successfully sign_up" do
    visit "users/new"

    sign_up!("my@email.com","Test1","Test1")

    page.must_have_content "Search Job"   #TODO: change to Hi, name when we implement that
                                            #after creating a user i'm signed in as well
    page.must_have_content "MyName" #flash    
  end

  it "only user can edit user" do
    log_in_as_user #firstname= Ema email= my@email.com password= Test1

    page.must_have_link "Hi, Ema"
    click_link "Hi, Ema"
    page.must_have_link "Edit"
    click_link 'Edit'

    user = User.find_by(email: "my@email.com")
    page.current_path.must_equal edit_user_path(user)
    page.must_have_css "#user_firstname"
    page.must_have_css "#user_lastname"
    page.must_have_selector("#user_gender")
    page.must_have_css "#user_email"
    page.must_have_css "#user_phone"
    page.must_have_css "#user_password"
    page.must_have_css "#user_confirm_password"

    within("//form[@id='edit_user_#{user.id}']") do
      fill_in 'Firstname', with: "EmaNew"
      fill_in 'Password', with: "Test1"
      fill_in 'Confirm Password', with: "Test1"
    end 
    click_button "Update User"

    page.current_path.must_equal "/users/#{user.id}"
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
    page.must_have_content "Search Job"
    page.current_path.must_equal "/"

    visit "sessions/new"

    submit!("my@email.com","Test1")
    page.must_have_content "User not found"
  end

  it "only admin block user" do
    log_in_as_user
    click_link "Hi, Ema"
    page.wont_have_link "Block"
    first('.top-bar').click_link("Sign Out")

    log_in_as_admin
    first('.top-bar').click_link("Users")
    page.must_have_link "my@email.com"
    click_link "my@email.com"
    page.must_have_button "Block"
    click_button "Block"
    page.must_have_content "Ema has been blocked"
    page.current_path.must_equal users_path
    first('.top-bar').click_link("Sign Out")

    log_in_as_user
    page.must_have_content "You have been blocked"

    log_in_as_admin
    click_link "Users"
    page.must_have_link "my@email.com"
    click_link "my@email.com"
    page.must_have_button "Un-Block"
    click_button "Un-Block"
    page.must_have_content "Ema has been unblocked"
    page.current_path.must_equal users_path
    first('.top-bar').click_link("Sign Out")
    
    log_in_as_user
    page.must_have_content "Welcome Ema!"
  end

end