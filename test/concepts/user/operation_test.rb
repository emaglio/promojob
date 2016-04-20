require 'test_helper'

class UserOperationTest < MiniTest::Spec
  it "validates correct input" do
    op = User::Create.(user: { firstname: "Ema" })
    op.model.persisted?.must_equal true
    op.model.firstname.must_equal "Ema"
  end

  it "Fails" do
    res,op = User::Create.run(user: { firstname: "" })
    res.must_equal false
    op.errors.to_s.must_equal "{:firstname=>[\"can't be blank\"]}"
  end

end
 