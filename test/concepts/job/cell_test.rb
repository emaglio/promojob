require "test_helper"

class JobCellTest < MiniTest::Spec
  include Cell::Testing
  controller UsersController

  include ::Capybara::DSL
  include ::Capybara::Assertions

  let (:user) {User::Create.(user: attributes_for(:user)).model}
  let (:job) {Job::Create.(job: attributes_for(:job), current_user: admin).model}
  let (:job2) {Job::Create.(job: attributes_for(:job, title: "Web Dev", description: "NewDecr"), current_user: admin).model}
  let (:job3) {Job::Create.(job: attributes_for(:job, title: "Cleaner", description: "NewDecr"), current_user: admin).model}
  let (:admin) {admin_for}
  jobApp1 = JobApplication::Apply.({user_id: user.id, job_id: job.id, 
                                    message: "This is great", status: "Apply", current_user: user}).model
  jobApp2 = JobApplication::Apply.({ user_id: user.id, job_id: job2.id, 
                                    message: "This is great", status: "Apply", current_user: user}).model
  jobApp3 = JobApplication::Apply.({ user_id: user.id, job_id: job3.id, 
                  message: "This is great", status: "Apply", current_user: user}).model

  JobApplication::Update.(id: jobApp2.id, job_application: {status: "Hire"}, current_user: admin)
  JobApplication::Update.(id: jobApp3.id, job_application: {status: "Reject"}, current_user: admin)

  it do
    html = concept("user/cell/index", users).()
    html.must_have_css("li", count: 3)
    html.must_have_css("li a", "bla0@blubb.de")
    html.must_have_css("li a", "bla1@blubb.de")
  end
end