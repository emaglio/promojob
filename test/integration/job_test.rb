require 'test_helper'

class JobIntegrationTest < Trailblazer::Test::Integration 

  it "unsuccessfull sign_up" do
    visit "jobs/new"

    page.must_have_css "#job_title"
    page.must_have_css "#job_company"
    page.must_have_css "#job_requirements"
    page.must_have_css "#job_description"
    page.must_have_css "#job_salary"
    page.must_have_css "#job_starts_at"
    page.must_have_button "Create Job"

    #empty
    fill_new_job!("","","")
    page.must_have_content "Titlecan't be blank"
    page.must_have_content "Requirementscan't be blank"
    page.must_have_content "Descriptioncan't be blank"

  end

  it "successfully sign_up" do
    visit "jobs/new"

    fill_new_job!("MyTitle","MyRequirements","MyDescription")

    #how do I test that I have created this user?
    #check which page is shown after clicking on Create User

  end

end
