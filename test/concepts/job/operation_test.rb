require 'test_helper'

class JobOperationTest < MiniTest::Spec
  	
	it "validates correct input" do
	  op = Job::Create.(job: { title: "AppSpec", company: "Nick's", requirements: "Beeing cool", description: "Showing hasses", salary: "100 $/hour" })
	  op.model.persisted?.must_equal true
	  op.model.title.must_equal "AppSpec"
	  op.model.company.must_equal "Nick's"
	  op.model.requirements.must_equal "Beeing cool"
	  op.model.description.must_equal "Showing hasses"
	  op.model.salary.must_equal "100 $/hour"
	end

<<<<<<< HEAD
	it "fails" do
	  res,op = Job::Create.run(job: { title: "", company: "Nick's", requirements: "Beeing cool", description: "Showing hasses", salary: "100 $/hour" })
	  res.must_equal false
	  op.errors.to_s.must_equal "{:title=>[\"can't be blank\"]}"
	 	res,op = Job::Create.run(job: { title: "AppSpec", company: "Nick's", requirements: "", description: "Showing hasses", salary: "100 $/hour" })
	  res.must_equal false
	  op.errors.to_s.must_equal "{:requirements=>[\"can't be blank\"]}"
	 	res,op = Job::Create.run(job: { title: "AppSpec", company: "Nick's", requirements: "Beeing cool", description: "", salary: "100 $/hour" })
	  res.must_equal false
	  op.errors.to_s.must_equal "{:description=>[\"can't be blank\"]}"
	end
=======

>>>>>>> 90a60630481bb5a41c3df778afd50a11d7396eba
end