require 'test_helper'

class JobApplicationIntegrationTest < Trailblazer::Test::Integration

  it "Unsuccessfull application" do
    #create a job
    log_in_as_admin
    visit "jobs/new"
    fill_new_job!("MyTitle","MyRequirements","MyDescription")
    
    #admin can't apply but only edit a job
    visit "jobs"
    page.must_have_link "MyTitle"
    click_link "MyTitle"
    page.wont_have_button "Apply"
    first('.top-bar').click_link("Sign Out")

    #no logged in
    visit "jobs"
    page.must_have_link "MyTitle"
    click_link "MyTitle"
    page.wont_have_button "Apply"
    page.must_have_content "Need to Sign In or create an account!" #flash
  end

  it "Successfull application" do
    #create a job
    log_in_as_admin
    visit "jobs/new"
    fill_new_job!("MyTitle","MyRequirements","MyDescription")
    first('.top-bar').click_link("Sign Out")

    #log in and apply
    log_in_as_user
    visit "jobs"
    page.must_have_link "MyTitle"
    click_link "MyTitle"
    page.must_have_content "MyRequirements"
    page.must_have_button "Apply"
    click_button "Apply"
    page.current_path.must_equal jobs_path
    page.must_have_content "You have applied for MyTitle" #flash
    page.wont_have_content "MyRequirements"
    page.wont_have_button "Apply"
    page.must_have_link "MyTitle"
  end

  it "can't apply twice for the same job" do
     #create a job
    log_in_as_admin
    visit "jobs/new"
    fill_new_job!("MyTitle","MyRequirements","MyDescription")
    first('.top-bar').click_link("Sign Out")

    #log in and apply once
    log_in_as_user
    visit "jobs"
    page.must_have_link "MyTitle"
    click_link "MyTitle"
    page.must_have_button "Apply"
    click_button "Apply"
    page.must_have_link "MyTitle"
    click_link "MyTitle"
    page.must_have_content "You have already applied for this job" #flash
    page.wont_have_button "Apply"
  end

  it "only admin can hire/reject JobApplication" do
    #create a job
    log_in_as_admin
    visit "jobs/new"
    fill_new_job!("MyTitle","MyRequirements","MyDescription")
    first('.top-bar').click_link("Sign Out")

    #log in and apply
    log_in_as_user
    visit "jobs"
    page.must_have_link "MyTitle"
    click_link "MyTitle"
    page.must_have_button "Apply"
    click_button "Apply"

    #user doesn't have Applied Job menu
    page.wont_have_link "Job Applications"
    first('.top-bar').click_link("Sign Out")

    #admin can hire/reject job_application
    log_in_as_admin

    #applied to hired
    page.must_have_link "Job Applications"
    click_link "Job Applications"
    page.must_have_content "Applied"
    page.must_have_content "Hired"
    page.must_have_content "Rejected"
    click_link "Applied"
    page.current_path.must_equal applications_job_applications_path
    page.must_have_link "MyTitle"
    click_link "MyTitle"

    jobApp = JobApplication.last
    page.current_path.must_equal edit_job_application_path(jobApp)
    page.must_have_content "MyTitle"
    page.must_have_content "MyRequirements"
    page.must_have_button "Update Job application"
    click_button "Update Job application"

    page.current_path.must_equal applications_job_applications_path
    page.wont_have_link "MyTitle"
    page.must_have_content "Job application updated"

    #hired to rejected
    click_link "Job Applications"
    click_link "Hired"
    page.current_path.must_equal applications_job_applications_path
    page.must_have_link "MyTitle"

    click_link "Job Applications"
    click_link "Rejected"
    page.current_path.must_equal applications_job_applications_path
    page.wont_have_link "MyTitle"

    click_link "Job Applications"
    click_link "Hired"
    click_link "MyTitle"
    select('Reject', :from => 'job_application_status')
    click_button "Update Job application"

    page.current_path.must_equal applications_job_applications_path
    page.must_have_content "Job application updated"
    click_link "Job Applications"
    click_link "Hired"
    page.wont_have_link "MyTitle"

    click_link "Job Applications"
    click_link "Rejected"
    click_link "MyTitle"

  end

  it "all positions fulfilled" do
    #create a job
    log_in_as_admin
    create_job("MyTitle","MyDescription")
    first('.top-bar').click_link("Sign Out")

    #log in and apply
    log_in_as_user
    visit "jobs"
    page.must_have_link "MyTitle"
    click_link "MyTitle"
    page.must_have_button "Apply"
    click_button "Apply"
    page.current_path.must_equal "/jobs"

    job_app = JobApplication.last

    #log in as differnt user and apply
    log_in_as_user("my2@email.com", "00")
    visit "jobs"
    page.must_have_link "MyTitle"
    click_link "MyTitle"
    page.must_have_button "Apply"
    click_button "Apply"
    page.current_path.must_equal "/jobs"

    #trying to hire both users
    #successfully hired
    log_in_as_admin
    click_link "Job Applications"
    click_link "Applied"
    find("a[href='/job_applications/#{job_app.id}/edit']").click
    # click_link "MyTitle"
    select('Hire', :from => 'job_application_status')
    click_button "Update Job application"
    page.must_have_content "Job application updated"
    page.current_path.must_equal applications_job_applications_path

    #error
    click_link "Job Applications"
    click_link "Applied"
    click_link "MyTitle"
    select('Hire', :from => 'job_application_status')
    click_button "Update Job application"
    page.must_have_content "All the positions for this job have been fulfilled"
    page.current_path.must_equal root_path
        
  end
end