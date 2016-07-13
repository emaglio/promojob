require 'test_helper'

class JobIntegrationTest < Trailblazer::Test::Integration 

  it "only admin creates jobs" do
    #not signed in
    visit "jobs/new"
    page.wont_have_content "Create Job"
    page.must_have_content "Need to Sign In or create an account!" #flash
    page.current_path.must_equal root_path

    # general user
    log_in_as_user

    visit "jobs/new"
    page.wont_have_content "Create Job"
    page.must_have_content "Not authorized, my friend." #flash
    page.current_path.must_equal root_path
    click_link "Sign Out"   

    # admin
    log_in_as_admin
    page.must_have_content "Hi, Admin"

    visit "jobs/new"
    page.current_path.must_equal new_job_path
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
    page.current_path.must_equal new_job_path

    #empty
    fill_new_job!("","","")
    page.must_have_content "can't be blank"
    page.current_path.must_equal jobs_path

  end

  it "successfully job creation" do
    log_in_as_admin
    page.must_have_content "Hi, Admin"    

    visit "jobs/new"

    fill_new_job!("MyTitle","MyRequirements","MyDescription")
    
    page.current_path.must_equal jobs_path
    page.must_have_content ("MyTitle")
    total = Job.all.size
    page.must_have_content (total)
    page.must_have_content "MyTitle job has been created" #flash
    click_link "MyTitle"


    page.must_have_content "MyRequirements"
    page.must_have_content "MyDescription"
    page.current_path.must_equal "/jobs/#{Job.last.id}"
  end

  it "unsuccessfull job editing" do
    log_in_as_admin
    create_job("MyTitle", "MyDescription")
    log_in_as_user

    job = Job.last
    visit "jobs/#{job.id}/edit"
    page.wont_have_content "MyRequirements"
    page.must_have_content "Not authorized, my friend." #flash

    visit "jobs"
    click_link "MyTitle"
    page.wont_have_link "Edit"
    page.must_have_button "Apply"
  end

  it "successfully job editing" do
    log_in_as_admin
    create_job("MyTitle", "MyDescription")

    visit "jobs"
    click_link "MyTitle"
    click_link "Edit"
    page.current_path.must_equal edit_job_path(Job.last.id)
    page.must_have_content "Edit MyTitle"
    page.must_have_button "Update Job"

    within("//form[@id='edit_job_#{Job.last.id}']") do
      fill_in 'Description', with: "TestDescription"
      fill_in 'Requirements', with: "TestRequirements"
    end 
    click_button "Update Job"
    
    page.current_path.must_equal "/jobs/#{Job.last.id}"
    page.must_have_content "TestDescription"
    page.must_have_content "TestRequirements"
    page.must_have_content "Job MyTitle has been updated" #flash
  end

  it "delete job" do
    log_in_as_admin
    create_job("MyTitle", "MyDescription")

    click_link "MyTitle"
    click_link "Delete"

    page.must_have_content "Job deleted" #flash
    page.wont_have_link "MyTitle"
  end

  it "search job" do
    log_in_as_admin
    create_job("OneTitle", "Description")
    create_job("SecondTitle", "Description")
    create_job("ThidTitle", "NewDescription")


    log_in_as_user
    visit "jobs"
    total = Job.all.size

    page.must_have_content total
    page.must_have_link "OneTitle"
    page.must_have_link "SecondTitle"
    page.must_have_link "ThidTitle"
    page.must_have_button "Search"

    fill_in 'keyword', with: 'OneTitle'
    click_button "Search"

    page.current_path.must_equal "/jobs/search"   
    page.must_have_link "OneTitle"
    page.wont_have_link "SecondTitle"
    page.wont_have_link "ThidTitle"
    
    fill_in 'keyword', with: 'Description'
    click_button "Search"

    page.must_have_link "OneTitle"
    page.must_have_link "SecondTitle"
    page.wont_have_link "ThidTitle"
    
    fill_in 'keyword', with: 'NewDescription'
    click_button "Search"

    page.wont_have_link "OneTitle"
    page.wont_have_link "SecondTitle"
    page.must_have_link "ThidTitle"
    

  end

end
