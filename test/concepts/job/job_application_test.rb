require 'test_helper'


class JobApplicationTest < MiniTest::Spec

  it "validates correct input" do
    #TODO: need to sign in as user
    job = Job::Create.(job: attributes_for(:job), current_user: admin_for)
    user = User::Create.(user: attributes_for(:user))
    
    op = Job::Apply.({ user_id: user_id, job_id: job_id, message: "This is great", status: "Applied" }, current_user: user)
    op.model.persisted?.must_equal true
    op.model.user_id.must_equal user.id
    op.model.job_id.must_equal job.id
    op.model.message.must_equal "This is great"
    op.model.status.must_equal "Applied"
  end

  it "fails" do # maybe no sense
    Session::SignIn.(:user)
    res,op = Job::Apply.run({})
    res.must_equal false
    op.errors.to_s.must_equal "{:job_id=>[\"can't be blank\"], :user_id=>[\"can't be blank\"]}"
  end

  it "no duplicate application" do
    Session::SignIn.(:user)
    res,op = Job::Apply.run({ user_id: user.id, job_id: job.id})
    res.must_equal true
    res,op = Job::Apply.run({ user_id: user.id, job_id: job.id})
    res.must_equal false 
    # op.errors.to_s.must_equal
  end

end
