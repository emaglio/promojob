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


end