require 'test_helper'

class UserOperationTest < MiniTest::Spec
  
  it "validates correct input" do
    op = User::Create.(user: { firstname: "Ema", lastname: "Maglio", gender: "Male", email: "my@email.com", phone: "0410123456", password: "Test1" })
    op.model.persisted?.must_equal true
    op.model.firstname.must_equal "Ema"
    op.model.lastname.must_equal "Maglio"
    op.model.gender.must_equal "Male"
    op.model.email.must_equal "my@email.com"
    op.model.phone.must_equal "0410123456"
    op.model.password.must_equal "Test1"
  end

  it "unique email and phone" do
    res,op = User::Create.run(user: { firstname: "Ema", lastname: "Maglio", gender: "Male", email: "my@email.com", phone: "0410100001", password: "Test1" })
    res.must_equal false
    op.errors.to_s.must_equal "{:email=>[\"has already been taken\"]}"
    res,op = User::Create.run(user: { firstname: "Ema", lastname: "Maglio", gender: "Male", email: "my1@email.com", phone: "0410123456", password: "Test1" })
    res.must_equal false
    op.errors.to_s.must_equal "{:phone=>[\"has already been taken\"], :email=>[\"has already been taken\"]}"
    #not sure about the message's error above
  end

  it "Fails" do
    res,op = User::Create.run(user: { firstname: "", lastname: "Maglio", gender: "Male", email: "my2@email.com", phone: "0410000010", password: "Test1" })
    res.must_equal false
    op.errors.to_s.must_equal "{:firstname=>[\"can't be blank\"]}"
    res,op = User::Create.run(user: { firstname: "Ema", lastname: "", gender: "Male", email: "my3@email.com", phone: "0410000100", password: "Test1" })
    res.must_equal false
    op.errors.to_s.must_equal "{:lastname=>[\"can't be blank\"]}"
    res,op = User::Create.run(user: { firstname: "Ema", lastname: "Maglio", gender: "", email: "my4@email.com", phone: "0410001000", password: "Test1" })
    res.must_equal false
    op.errors.to_s.must_equal "{:gender=>[\"can't be blank\"]}"
    res,op = User::Create.run(user: { firstname: "ema", lastname: "Maglio", gender: "Male", email: "", phone: "0410010000", password: "Test1" })
    res.must_equal false
    op.errors.to_s.must_equal "{:email=>[\"can't be blank\", \"is invalid\"]}"
    res,op = User::Create.run(user: { firstname: "Ema", lastname: "Maglio", gender: "Male", email: "my5@email.com", phone: "", password: "Test1" })
    res.must_equal false
    op.errors.to_s.must_equal "{:phone=>[\"Double check your phone number please\"]}"
    res,op = User::Create.run(user: { firstname: "Ema", lastname: "Maglio", gender: "Male", email: "my6@email.com", phone: "0410010000", password: "" })
    res.must_equal false
    op.errors.to_s.must_equal "{:password=>[\"can't be blank\", \"must have at least 5 characters\", \"must have at least: one number between 0 and 9; one Upper Case letter; one Lower Case letter\"]}"
  end

  it "password fails" do
    res,op = User::Create.run(user: {firstname: "Ema", lastname: "Maglio", gender: "Male", email: "new@email.com", phone:"0410654321", password:"Test" })
    res.must_equal false
    op.errors.to_s.must_equal "{:password=>[\"must have at least 5 characters\", \"must have at least: one number between 0 and 9; one Upper Case letter; one Lower Case letter\"]}"
    res,op = User::Create.run(user: {firstname: "Ema", lastname: "Maglio", gender: "Male", email: "new1@email.com", phone:"0410654321", password:"Testing" })
    res.must_equal false
    op.errors.to_s.must_equal "{:password=>[\"must have at least: one number between 0 and 9; one Upper Case letter; one Lower Case letter\"]}"
    res,op = User::Create.run(user: {firstname: "Ema", lastname: "Maglio", gender: "Male", email: "new2@email.com", phone:"0410654321", password:"test1" })
    res.must_equal false
    op.errors.to_s.must_equal "{:password=>[\"must have at least: one number between 0 and 9; one Upper Case letter; one Lower Case letter\"]}"
    res,op = User::Create.run(user: {firstname: "Ema", lastname: "Maglio", gender: "Male", email: "new3@email.com", phone:"0410654321", password:"TEST1" })
    res.must_equal false
    op.errors.to_s.must_equal "{:password=>[\"must have at least: one number between 0 and 9; one Upper Case letter; one Lower Case letter\"]}"
  end

  it "email format fails" do
    res,op = User::Create.run(user: {firstname: "Ema", lastname: "Maglio", gender: "Male", email: "@email.com", phone:"0410110000", password:"Test1" })
    res.must_equal false
    op.errors.to_s.must_equal "{:email=>[\"is invalid\"]}"
    res,op = User::Create.run(user: {firstname: "Ema", lastname: "Maglio", gender: "Male", email: "testemail.com", phone:"0410110001", password:"Test1" })
    res.must_equal false
    op.errors.to_s.must_equal "{:email=>[\"is invalid\"]}"
    res,op = User::Create.run(user: {firstname: "Ema", lastname: "Maglio", gender: "Male", email: "test@emailcom", phone:"0410110010", password:"Test1" })
    res.must_equal false
    op.errors.to_s.must_equal "{:email=>[\"is invalid\"]}"
    res,op = User::Create.run(user: {firstname: "Ema", lastname: "Maglio", gender: "Male", email: "test@.com", phone:"0410110100", password:"Test1" })
    res.must_equal false
    op.errors.to_s.must_equal "{:email=>[\"is invalid\"]}"
  end

end
