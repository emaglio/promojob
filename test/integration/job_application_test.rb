require 'test_helper'

class JobApplicationIntegrationTest < Trailblazer::Test::Integration

  it "Unsuccessfull application" do
    #create a job
    log_in_as_admin
    visit "jobs/new"
    fill_new_job!("MyTitle","MyRequirements","MyDescription")
    
    #admin can't apply only edit a job
    visit "jobs"
    page.must_have_link "MyTitle"
    click_link "MyTitle"
    page.wont_have_button "Apply"
    click_link "Sign Out"

    #no logged in
    visit "jobs"
    page.must_have_link "MyTitle"
    click_link "MyTitle"
    page.wont_have_button "Apply"
  end

  it "Successfull application" do
    #create a job
    log_in_as_admin
    visit "jobs/new"
    fill_new_job!("MyTitle","MyRequirements","MyDescription")
    click_link "Sign Out"

    #log in and apply
    log_in_as_user
    visit "jobs"
    page.must_have_link "MyTitle"
    click_link "MyTitle"
    page.must_have_content "MyRequirements"
    page.must_have_button "Apply"
    click_button "Apply"
    #test flash message
    page.wont_have_content "MyRequirements"
    page.wont_have_button "Apply"
    page.must_have_link "MyTitle"
  end

  it "can't apply twice for the same job" do
     #create a job
    log_in_as_admin
    visit "jobs/new"
    fill_new_job!("MyTitle","MyRequirements","MyDescription")
    click_link "Sign Out"

    #log in and apply once
    log_in_as_user
    visit "jobs"
    page.must_have_link "MyTitle"
    click_link "MyTitle"
    page.must_have_button "Apply"
    click_button "Apply"
    page.must_have_link "MyTitle"
    click_link "MyTitle"
    #test flash message
    page.wont_have_button "Apply"
  end

  it "only admin can hire/reject JobApplication" do
    #create a job
    log_in_as_admin
    visit "jobs/new"
    fill_new_job!("MyTitle","MyRequirements","MyDescription")
    click_link "Sign Out"

    #log in and apply
    log_in_as_user
    visit "jobs"
    page.must_have_link "MyTitle"
    click_link "MyTitle"
    page.must_have_button "Apply"
    click_button "Apply"

    #user doesn't have Applied Job menu
    page.wont_have_link "Applied Jobs"
    click_link "Sign Out"

    #admin can hire/reject job_application
    log_in_as_admin
    page.must_have_link "Applied Jobs"
    click_link "Applied Jobs"

    page.must_have_link "MyTitle"
    click_link "MyTitle"

    page.must_have_content "MyTitle"
    page.must_have_content "MyRequirements"
    page.must_have_button "Update Job application"
    click_button "Update Job application"

    page.wont_have_link "MyTitle"
  end

end