require 'test_helper'

class JobIntegrationTest < Trailblazer::Test::Integration 

  it "only admin creates jobs" do
    #not signed in
    visit "jobs/new"
    page.wont_have_content "Create Job"

    # general user
    log_in_as_user

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
    total = Job.all.size
    # page.must_have_content ("You've got " + str(total) + " jobs.")
    page.must_have_content (total)
    click_link "MyTitle"

    page.must_have_content "MyRequirements"
    page.must_have_content "MyDescription"
  end

  it "unsuccessfull job editing" do
    log_in_as_admin
    create_job #MyTitle, MyRequirements, MyDescription
    log_in_as_user

    visit "jobs/1/edit"
    page.wont_have_content "MyRequirements"

    visit "jobs"
    click_link "MyTitle"
    page.wont_have_link "Edit"
    page.must_have_button "Apply"
  end

  it "successfully job editing" do
    log_in_as_admin
    create_job

    visit "jobs"
    click_link "MyTitle"
    click_link "Edit"
    page.must_have_content "Edit MyTitle"
    page.must_have_button "Update Job"

    within("//form[@id='edit_job_1']") do
      fill_in 'Description', with: "TestDescription"
      fill_in 'Requirements', with: "TestRequirements"
    end 
    click_button "Update Job"
    
    page.must_have_content "TestDescription"
    page.must_have_content "TestRequirements"
  end



end
