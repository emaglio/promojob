require 'test_helper'


class JobApplicationTest < MiniTest::Spec

  let (:user) {User::Create.(user: attributes_for(:user)).model}
  let (:job) {Job::Create.(job: attributes_for(:job), current_user: admin_for).model}

  it "validates correct input" do  
    op = Job::Apply.({ user_id: user.id, job_id: job.id, message: "This is great", status: "Applied", current_user: user})
    op.model.persisted?.must_equal true
    op.model.user_id.must_equal user.id
    op.model.job_id.must_equal job.id
    op.model.message.must_equal "This is great"
    op.model.status.must_equal "Applied"
  end

  it "fails" do # maybe no sense
    res,op = Job::Apply.run({current_user: user})
    res.must_equal false
    op.errors.to_s.must_equal "{:job_id=>[\"can't be blank\"], :user_id=>[\"can't be blank\"]}"
  end

  it "no duplicate application" do
    res,op = Job::Apply.run({ user_id: user.id, job_id: job.id, current_user: user})
    res.must_equal true
    res,op = Job::Apply.run({ user_id: user.id, job_id: job.id, current_user: user})
    res.must_equal false 
    op.errors.to_s.must_equal "{:user_id=>[\"has already been taken\"]}"
  end

  it "only admin can Hire/Reject a job_application" do 
    op = Job::Apply.({ user_id: user.id, job_id: job.id, message: "This is great", status: "Applied", current_user: user})

    op.model.persisted?.must_equal true

    # assert_raises Trailblazer::NotAuthorizedError do
    #   Job::UpdateApplication.(
    #     id: JobApplication.last,
    #     current_user: user)
    # end
    
    op = Job::UpdateApplication.(id: JobApplication.last, status: "Hire", current_user: admin_for)
    op.model.persisted?.must_equal true
    op.model.user_id.must_equal user.id
    op.model.job_id.must_equal jop.id
    op.model.status.must_equal "Hire"


  end
end
