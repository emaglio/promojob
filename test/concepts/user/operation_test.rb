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
    res,op = User::Create.run(user: { firstname: "Ema", lastname: "Maglio", gender: "Male", email: "my@email.com", phone: "04101000001" })
    res.must_equal false
    op.errors.to_s.must_equal "{:email=>[\"has already been taken\"]}"
    res,op = User::Create.run(user: { firstname: "Ema", lastname: "Maglio", gender: "Male", email: "my1@email.com", phone: "0410123456" })
    res.must_equal false
    op.errors.to_s.must_equal ":phone=>[\"has already been taken\"]}"
  end

  it "Fails" do
    res,op = User::Create.run(user: { firstname: "", lastname: "Maglio", gender: "Male", email: "my2@email.com", phone: "0410000010" })
    res.must_equal false
    op.errors.to_s.must_equal "{:firstname=>[\"can't be blank\"]}"
    res,op = User::Create.run(user: { firstname: "Ema", lastname: "", gender: "Male", email: "my3@email.com", phone: "0410000100" })
    res.must_equal false
    op.errors.to_s.must_equal "{:lastname=>[\"can't be blank\"]}"
    res,op = User::Create.run(user: { firstname: "Ema", lastname: "Maglio", gender: "", email: "my4@email.com", phone: "0410001000" })
    res.must_equal false
    op.errors.to_s.must_equal "{:gender=>[\"can't be blank\"]}"
    res,op = User::Create.run(user: { firstname: "ema", lastname: "Maglio", gender: "Male", email: "", phone: "04100100000" })
    res.must_equal false
    op.errors.to_s.must_equal "{:email=>[\"can't be blank\"]}"
    res,op = User::Create.run(user: { firstname: "Ema", lastname: "Maglio", gender: "Male", email: "my5@email.com", phone: "" })
    res.must_equal false
    op.errors.to_s.must_equal "{:phone=>[\"can't be blank\"]}"
  end

end
