require 'test_helper'

class JobOperationTest < MiniTest::Spec
	it "validates correct input" do
	  op = Job::Create.(job: attributes_for(:job), current_user: admin_for)
	  op.model.persisted?.must_equal true
	  op.model.title.must_equal "AppSpec"
	  op.model.company.must_equal "Nick's"
	  op.model.requirements.must_equal "Beeing cool"
	  op.model.description.must_equal "Showing hasses"
	  op.model.salary.must_equal "100 $/hour"
	  op.model.starts_at.must_equal DateTime.parse("Mon, 01 Feb 2016 12:12:00 UTC +00:00") #needed different king of test
	end

	it "fails" do
	  #no title, description and requirements
	  res, op = Job::Create.run(job: attributes_for(:job, title: "", requirements: "", description: ""), current_user: admin_for)
	  res.must_equal false
	  op.errors.to_s.must_equal "{:title=>[\"can't be blank\"], :requirements=>[\"can't be blank\"], :description=>[\"can't be blank\"]}"
	end

	it "only admin can edit the job" do
		user = User::Create.(user: attributes_for(:user)).model
		admin = User::Create.(user: attributes_for(:user, email: "info@cj-agency.de", phone: "98")).model
		job = Job::Create.(job: attributes_for(:job), current_user: admin).model

		assert_raises Trailblazer::NotAuthorizedError do
      Job::Update.(
        id: job.id,
        job: {description: "Test"},
        current_user: user)
    end

    job.description.must_equal "Showing hasses"
    op = Job::Update.(id: job.id, job: {description: "Test"}, current_user: admin)
    op.model.persisted?.must_equal true 
    op.model.description.must_equal "Test"
  end

end
