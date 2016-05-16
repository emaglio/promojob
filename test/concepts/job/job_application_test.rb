require 'test_helper'


class JobApplicationTest < MiniTest::Spec

  let (:user) {User::Create.(user: attributes_for(:user)).model}
  let (:job) {Job::Create.(job: attributes_for(:job)).model}

  it "validates correct input" do
    op = Job::Apply.({ user_id: user.id, job_id: job.id, message: "This is great", status: "Applied" })
    op.model.persisted?.must_equal true
    op.model.user_id.must_equal user.id
    op.model.job_id.must_equal job.id
    op.model.message.must_equal "This is great"
    op.model.status.must_equal "Applied"
  end

  it "fails" do # maybe no sense
    res,op = Job::Apply.run({})
    res.must_equal false
    op.errors.to_s.must_equal "{:job_id=>[\"can't be blank\"], :user_id=>[\"can't be blank\"]}"
  end
end
