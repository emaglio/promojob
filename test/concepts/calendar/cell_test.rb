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
  
  let! (:job2) {Job::Create.(job: attributes_for(:job, 
                            title: "Web Dev", 
                            description: "NewDecr",
                            user_count: "2", 
                            starts_at: "04-02-2016 10:00", 
                            ends_at: "06-02-2016 10:00" ), current_user: admin).model}
  
  let! (:job3) {Job::Create.(job: attributes_for(:job, 
                            title: "Buyer", 
                            description: "Buying",
                            user_count: "2", 
                            starts_at: "10-02-2016 10:00", 
                            ends_at: "11-02-2016 10:00" ), current_user: admin).model}
  it "admin calendar" do #TODO: add test for the decoration
    html = concept("my/cell/calendar", nil, offset: 0, starts_at: DateTime.parse("03-02-2016"),
                  context: {policy: Session::Policy.new(admin, nil)}).()
    html.all("li")[9].must_have_css(".row", text: "03")
    html.all("li")[9].find_link("AppSpec")
    html.all("li")[9].must_have_css(".row", text: " ")
    html.all("li")[10].must_have_css(".row", text: "04")
    html.all("li")[10].find_link("AppSpec")
    html.all("li")[10].find_link("Web Dev")
    html.all("li")[11].must_have_css(".row", text: "05")
    html.all("li")[11].find_link("AppSpec")
    html.all("li")[11].find_link("Web Dev")
    html.all("li")[12].must_have_css(".row", text: "06")
    html.all("li")[12].find_link("Web Dev")
    html.all("li")[16].must_have_css(".row", text: "10")
    html.all("li")[16].find_link("Buyer")
    html.all("li")[17].must_have_css(".row", text: "11")
    html.all("li")[17].find_link("Buyer")
  end

  it "user calendar" do 
    
  end
end
