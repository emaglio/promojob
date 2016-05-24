ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require "minitest/autorun"
require "trailblazer/rails/test/integration"

Rails.backtrace_cleaner.remove_silencers!

Minitest::Spec.class_eval do
  after :each do
    # DatabaseCleaner.clean
    # Thing.delete_all
    # Comment.delete_all
    User.delete_all
  end
  include FactoryGirl::Syntax::Methods

  def  admin_for
    User::Create.(user: attributes_for(:user, email: "info@cj-agency.de"))
  end
end

FactoryGirl.find_definitions


Cell::TestCase.class_eval do
  include Capybara::DSL
  include Capybara::Assertions
end

Trailblazer::Test::Integration.class_eval do
  def sign_in!(email="fred@trb.org", password="123456")
    sign_up!(email, password) #=> Session::SignUp

    visit "/sessions/sign_in_form"

    submit!(email, password)
  end

  def sign_up!(email="fred@trb.org", password="123456")
    User::Create.(user: {email: email, password: password})
  end

  def submit!(email, password)
    # puts page.body
    within("//form[@id='new_session']") do
      fill_in 'Email',    with: email
      fill_in 'Password', with: password
    end
    click_button "Sign In"
  end
end
