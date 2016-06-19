require 'test_helper'


class JobApplicationTest < MiniTest::Spec

  let (:user) {User::Create.(user: attributes_for(:user)).model}
  let (:user2) {User::Create.(user: attributes_for(:user, email: "test@mail.com", phone: "00")).model}
  let (:job) {Job::Create.(job: attributes_for(:job), current_user: admin).model}
  let (:job2) {Job::Create.(job: attributes_for(:job, title: "Web Dev"), current_user: admin).model}
  let (:admin) {admin_for}

  it "validates correct input" do  
    op = JobApplication::Apply.({ user_id: user.id, job_id: job.id, message: "This is great", status: "Applied", current_user: user})
    op.model.persisted?.must_equal true
    op.model.user_id.must_equal user.id
    op.model.job_id.must_equal job.id
    op.model.message.must_equal "This is great"
    op.model.status.must_equal "Applied"
  end

  it "fails" do # maybe no sense
    res,op = JobApplication::Apply.run({current_user: user})
    res.must_equal false
    op.errors.to_s.must_equal "{:job_id=>[\"can't be blank\"], :user_id=>[\"can't be blank\"]}"
  end

  it "no duplicate application" do
    res,op = JobApplication::Apply.run({ user_id: user.id, job_id: job.id, current_user: user})
    res.must_equal true
    res,op = JobApplication::Apply.run({ user_id: user.id, job_id: job.id, current_user: user})
    res.must_equal false 
    op.errors.to_s.must_equal "{:user_id=>[\"has already been taken\"]}"
  end

  it "only admin can Hire/Reject a job_application" do
    op = JobApplication::Apply.({ user_id: user.id, job_id: job.id, message: "This is great", status: "Applied", current_user: user})
    op.model.persisted?.must_equal true

    jobApp = JobApplication.last
    jobApp.status = "Hire"
    assert_raises Trailblazer::NotAuthorizedError do
      JobApplication::Update.(
        id: jobApp.id,
        job_application: jobApp,
        current_user: user)
    end
    
    JobApplication::Update.present({id: jobApp.id, job_application: jobApp, current_user: admin})
    jobApp.user_id.must_equal user.id
    jobApp.job_id.must_equal job.id
    jobApp.status.must_equal "Hire"
  end

  it "delete jobApp after delete user" do
    #same user applies for the same job 
    op = JobApplication::Apply.({ user_id: user.id, job_id: job.id, message: "This is great", status: "Applied", current_user: user})
    op.model.persisted?.must_equal true
    op = JobApplication::Apply.({ user_id: user.id, job_id: job2.id, message: "This is great2", status: "Applied", current_user: user})
    op.model.persisted?.must_equal true

    jobApps = JobApplication.where("user_id = ?", user.id)
    jobApps.size.must_equal 2

    op = User::Delete.({id: user.id, current_user: user})

    jobApps = JobApplication.where("user_id = ?", user.id)
    jobApps.size.must_equal 0
  end

  it "delete jobApp after delete job" do 
    #same job for 2 different users
    op = JobApplication::Apply.({ user_id: user.id, job_id: job.id, message: "This is great", status: "Applied", current_user: user})
    op.model.persisted?.must_equal true
    op = JobApplication::Apply.({ user_id: user2.id, job_id: job.id, message: "This is great2", status: "Applied", current_user: user})
    op.model.persisted?.must_equal true

    jobApps = JobApplication.where("job_id = ?", job.id)
    jobApps.size.must_equal 2

    op = Job::Delete.({id: job.id, current_user: admin})

    jobApps = JobApplication.where("job_id = ?", job.id)
    jobApps.size.must_equal 0
  end
end
