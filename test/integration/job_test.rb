require 'test_helper'

class JobIntegrationTest < Trailblazer::Test::Integration 

  it "only admin creates jobs" do
    #not signed in
    visit "jobs/new"
    page.wont_have_content "Create Job"

    # general user
    op = User::Create.(user: FactoryGirl.attributes_for(:user))

    visit "sessions/new"
    submit!(op.model.email, "Test1")

    visit "jobs/new"
    page.wont_have_content "Create Job"

    click_link "Sign Out"

    # admin
    log_in_as_admin
    page.must_have_content "Hi, Admin"

    visit "jobs/new"
    page.must_have_css "#job_title"     
    
  end

  it "unsuccessfull job creation" do
    log_in_as_admin
    page.must_have_content "Hi, Admin"

    visit "jobs/new"

    page.must_have_css "#job_title"
    page.must_have_css "#job_company"
    page.must_have_css "#job_requirements"
    page.must_have_css "#job_description"
    page.must_have_css "#job_salary"
    # page.must_have_css "#job_starts_at" TODO: how to test this?
    page.must_have_button "Create Job"

    #empty
    fill_new_job!("","","")
    page.must_have_content "can't be blank"

  end

  it "successfully job creation" do
    log_in_as_admin
    page.must_have_content "Hi, Admin"    

    visit "jobs/new"

    fill_new_job!("MyTitle","MyRequirements","MyDescription")
    
    page.must_have_content ("MyTitle")
    page.must_have_content ("You've got 1 jobs.")
    click_link "MyTitle"

    page.must_have_content "MyRequirements"
    page.must_have_content "MyDescription"
  end

end
