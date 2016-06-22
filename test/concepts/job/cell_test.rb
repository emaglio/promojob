require "test_helper"

class JobCellTest < MiniTest::Spec
  include Cell::Testing
  controller UsersController

  include ::Capybara::DSL
  include ::Capybara::Assertions

  let (:users) { 2.times.collect { |i| User::Create.(
    user: { firstname: "Manu", lastname: "Maz", gender: "m", age: "30", 
      phone: "012345678#{i}", email: "bla#{i}@blubb.de", password: "1ABbadasfasdf", 
      confirm_password: "1ABbadasfasdf"}
  ).model } }

  it do
    html = concept("user/cell/index", users).()
    html.must_have_css("li", count: 3)
    html.must_have_css("li a", "bla0@blubb.de")
    html.must_have_css("li a", "bla1@blubb.de")
  end
end