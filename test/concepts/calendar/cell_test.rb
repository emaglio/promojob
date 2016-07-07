require "test_helper"

class CalendarCellTest < MiniTest::Spec
  include Cell::Testing
  controller MyController

  include ::Capybara::DSL
  include ::Capybara::Assertions

  let(:admin) {admin_for}
  let! (:job) {Job::Create.(job: attributes_for(:job, 
                          starts_at: "03-02-2016 10:00",
                          ends_at: "05-02-2016 18:00"), current_user: admin).model}
  let! (:job2) {Job::Create.(job: attributes_for(:job, title: "Web Dev", description: "NewDecr", 
                            starts_at: "04-02-2016 10:00", ends_at: "06-02-2016 10:00" ), current_user: admin).model}

  it do
    html = concept("my/cell/calendar", nil, offset: 0, starts_at: DateTime.parse("03-02-2016"),
                  context: {policy: Session::Policy.new(admin, nil)}).()
    # html.must_have_css("li", text: "3App")
    html.all("li")[9].must_have_css(".row", text: "03")
    html.all("li")[9].must_have_css(".row", text: "AppSpec")
    html.all("li")[10].must_have_css(".row", text: "04")
    html.all("li")[10].must_have_css(".row", text: "AppSpec,Web Dev")
    html.all("li")[11].must_have_css(".row", text: "05")
    html.all("li")[11].must_have_css(".row", text: "AppSpec,Web Dev")
    html.all("li")[12].must_have_css(".row", text: "06")
    html.all("li")[12].must_have_css(".row", text: "Web Dev")
  end
end
