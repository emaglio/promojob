ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara-webkit'
require "minitest/autorun"
require "trailblazer/rails/test/integration"

Rails.backtrace_cleaner.remove_silencers!

Minitest::Spec.class_eval do
  after :each do
    # DatabaseCleaner.clean
    # ::Job.delete_all
    # ::JobApplication.delete_all
    ::User.delete_all
  end
  include FactoryGirl::Syntax::Methods

  def admin_for
    User::Create.(user: attributes_for(:user, email: "info@cj-agency.de", phone: "1")).model
  end
  
end

FactoryGirl.find_definitions

Cell::TestCase.class_eval do
  include Capybara::DSL
  include Capybara::Assertions
end

Trailblazer::Test::Integration.class_eval do

  def sign_up!(email="fred@trb.org", password="123456", confirm_password="123456")
    within("//form[@id='new_user']") do
      fill_in 'Firstname', with: "MyName"
      fill_in 'Lastname', with: "MyLastname"
      select('Male', :from => 'user_gender')
      fill_in 'Age', with: "30" 
      fill_in 'Phone', with: "0192012"
      fill_in 'Email',    with: email
      fill_in 'Password', with: password
      fill_in 'Confirm Password', with: confirm_password
    end
    click_button "Create User"
  end

  def fill_new_job!(title="NewTitle", requirements="newRequirments", description="newJob")
    within("//form[@id='new_job']") do
      fill_in 'Company', with: "MyCompany"
      fill_in 'Salary', with: "0aud"
      fill_in 'Number of Position to fulfill', with: "1"
      fill_in 'Title',    with: title
      fill_in 'Requirements', with: requirements
      fill_in 'Description', with: description
    end
    # page.execute_script("$('#job_starts_at').val('12/12/2016')")
    # page.execute_script("$('#job_ends_at').val('13/12/2016')")
    click_button "Create Job"

    unless title == ""
      admin = ::User.find_by(:email => "info@cj-agency.de")
      job = ::Job.last
      op = ::Job::Update.(id: job.id, job: { starts_at: DateTime.parse("Mon, 01 Feb 2016 12:12:00 UTC +00:00"),
                                        ends_at: DateTime.parse("Mon, 02 Feb 2016 12:12:00 UTC +00:00") 
                                        }, current_user: admin)
    end
  end

    def submit!(email, password)
    # puts page.body
    within(:xpath, "//form[@id='new_session']") do
      fill_in 'Email',    with: email
      fill_in 'Password', with: password
    end
    click_button "Sign In"
  end

  def log_in_as_admin
    if ::User.where(email: "info@cj-agency.de").size == 0
      ::User::Create.(user: FactoryGirl.attributes_for(:user, email: "info@cj-agency.de", firstname: "Admin", phone: "0"))
    end
    visit "sessions/new"
    submit!("info@cj-agency.de", "Test1")
  end

  def log_in_as_user(email = "my@email.com", phone = "0410123456")
    user = User.find_by(email: email) 
    unless user
      user = User::Create.(user: FactoryGirl.attributes_for(:user, email: email, phone: phone)).model
    end

    visit "sessions/new"
    submit!(user.email, "Test1")
  end

  def create_job(title, description)
    visit "jobs/new"

    fill_new_job!(title,"MyRequirements",description)
  end

end
