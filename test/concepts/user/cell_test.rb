require "test_helper"

class UserCellTest < MiniTest::Spec
  include Cell::Testing
  controller UsersController

  include ::Capybara::DSL
  include ::Capybara::Assertions

  let (:users) { 2.times.collect { |i| User::Create.(
    user: { firstname: "Manu", lastname: "Maz", gender: "m", phone: "012345678#{i}", email: "bla#{i}@blubb.de", password: "1ABbadasfasdf", confirm_password: "1ABbadasfasdf"}
  ).model } }

  it do
    html = concept("user/cell/index", users).()
    html.must_have_css("li", count: 2)
    html.must_have_css("li a", "0123456780")
    html.must_have_css("li a", "0123456781")
  end
end
