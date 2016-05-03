require 'test_helper'

class JobOperationTest < MiniTest::Spec

	it "validates correct input" do
	  op = Job::Create.(job: attributes_for(:job))
	  op.model.persisted?.must_equal true
	  op.model.title.must_equal "AppSpec"
	  op.model.company.must_equal "Nick's"
	  op.model.requirements.must_equal "Beeing cool"
	  op.model.description.must_equal "Showing hasses"
	  op.model.salary.must_equal "100 $/hour"
	  op.model.startingday.must_equal "12/12/12"
	end

	it "fails" do
	  res, op = Job::Create.run(job: attributes_for(:job, title: ""))
	  res.must_equal false
	  op.errors.to_s.must_equal "{:title=>[\"can't be blank\"]}"
	  res, op = Job::Create.run(job: attributes_for(:job, requirements: ""))
	  res.must_equal false
	  op.errors.to_s.must_equal "{:requirements=>[\"can't be blank\"]}"
	  res, op = Job::Create.run(job: attributes_for(:job, description: ""))
	  res.must_equal false
	  op.errors.to_s.must_equal "{:description=>[\"can't be blank\"]}"
	end
end
