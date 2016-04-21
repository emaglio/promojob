require 'test_helper'

class UserOperationTest < MiniTest::Spec
  it "validates correct input" do
    op = User::Create.(user: { firstname: "Ema", lastname: "Maglio", gender: "Male", email: "my@email.com", phone: "0410123456" })
    op.model.persisted?.must_equal true
    op.model.firstname.must_equal "Ema"
    op.model.lastname.must_equal "Maglio"
    op.model.gender.must_equal "Male"
    op.model.email.must_equal "my@email.com"
    op.model.phone.must_equal "0410123456"
  end

  it "unique email and phone" do
    op = User::Create.(user: { firstname: "Ema", lastname: "Maglio", gender: "Male", email: "my@email.com", phone: "0410123456" })
    res,op = User::Create.run(user: { firstname: "Ema", lastname: "Maglio", gender: "Male", email: "my@email.com", phone: "0410123456" })
    res.must_equal false
    op.errors.to_s.must_equal "{:phone=>[\"has already been taken\"], :email=>[\"has already been taken\"]}"
  end

  it "Fails" do
    res,op = User::Create.run(user: { firstname: "asd", lastname: "", gender: "asd", email: "asd", phone: "asd" })
    res.must_equal false
    op.errors.to_s.must_equal "{:firstname=>[\"can't be blank\"]}"
  end

end
 