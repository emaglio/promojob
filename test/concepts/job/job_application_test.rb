require 'test_helper'


class JobApplicationTest < MiniTest::Spec

  it "validates correct input" do
    #TODO: need to sign in as user
    job = Job::Create.(job: attributes_for(:job), current_user: admin_for)
    user = User::Create.(user: attributes_for(:user))
    
    op = Job::Apply.({ user_id: user.model.id, job_id: job.model.id, message: "This is great", status: "Applied", current_user: user.model})
    op.model.persisted?.must_equal true
    op.model.user_id.must_equal user.model.id
    op.model.job_id.must_equal job.model.id
    op.model.message.must_equal "This is great"
    op.model.status.must_equal "Applied"
  end

  it "fails" do # maybe no sense
    job = Job::Create.(job: attributes_for(:job), current_user: admin_for)
    user = User::Create.(user: attributes_for(:user))

    res,op = Job::Apply.run({current_user: user.model})
    res.must_equal false
    op.errors.to_s.must_equal "{:job_id=>[\"can't be blank\"], :user_id=>[\"can't be blank\"]}"
  end

  it "no duplicate application" do
    job = Job::Create.(job: attributes_for(:job), current_user: admin_for)
    user = User::Create.(user: attributes_for(:user))
    
    res,op = Job::Apply.run({ user_id: user.model.id, job_id: job.model.id, current_user: user.model})
    res.must_equal true
    res,op = Job::Apply.run({ user_id: user.model.id, job_id: job.model.id, current_user: user.model})
    res.must_equal false 
    op.errors.to_s.must_equal "{:user_id=>[\"has already been taken\"]}"
  end

end
