require 'test_helper'

class UserOperationTest < MiniTest::Spec

  it "validates correct input" do
    op = User::Create.(user: attributes_for(:user))
    op.model.persisted?.must_equal true
    op.model.firstname.must_equal "Ema"
    op.model.lastname.must_equal "Maglio"
    op.model.gender.must_equal "Male"
    op.model.age.must_equal 30
    op.model.email.must_equal "my@email.com"
    op.model.phone.must_equal "0410123456"
    assert op.model.auth_meta_data["confirmed_at"]
  end

  it "unique email and phone" do
    res,op = User::Create.run(user: attributes_for(:user, email: "my1@email.com", phone: "0410100001"))
    res.must_equal true
    res,op = User::Create.run(user: attributes_for(:user, email: "my1@email.com", phone: "0410100001"))
    res.must_equal false
    op.errors.to_s.must_equal "{:phone=>[\"has already been taken\"], :email=>[\"has already been taken\"]}"
  end


  it "Fails" do
    res,op = User::Create.run(user: attributes_for(:user, firstname: ""))
    res.must_equal false
    op.errors.to_s.must_equal "{:firstname=>[\"can't be blank\"]}"
    res,op = User::Create.run(user: attributes_for(:user, lastname: ""))
    res.must_equal false
    op.errors.to_s.must_equal "{:lastname=>[\"can't be blank\"]}"
    res,op = User::Create.run(user: attributes_for(:user, gender: ""))
    res.must_equal false
    op.errors.to_s.must_equal "{:gender=>[\"can't be blank\"]}"
    res,op = User::Create.run(user: attributes_for(:user, email: ""))
    res.must_equal false
    op.errors.to_s.must_equal "{:email=>[\"can't be blank\", \"is invalid\"]}"
    res,op = User::Create.run(user: attributes_for(:user, phone: ""))
    res.must_equal false
    op.errors.to_s.must_equal "{:phone=>[\"can't be blank\"]}"
    res,op = User::Create.run(user: attributes_for(:user, password: ""))
    res.must_equal false
    op.errors.to_s.must_equal "{:password=>[\"Passwords don't match\", \"can't be blank\", \"must have at least 5 characters\", \"must have at least: one number between 0 and 9; one Upper Case letter; one Lower Case letter\"]}"
  end

  it "password fails" do
    res,op = User::Create.run(user: attributes_for(:user, password: "Test"))
    res.must_equal false
    op.errors.to_s.must_equal "{:password=>[\"Passwords don't match\", \"must have at least 5 characters\", \"must have at least: one number between 0 and 9; one Upper Case letter; one Lower Case letter\"]}"
    res,op = User::Create.run(user: attributes_for(:user, password: "Testing"))
    res.must_equal false
    op.errors.to_s.must_equal "{:password=>[\"Passwords don't match\", \"must have at least: one number between 0 and 9; one Upper Case letter; one Lower Case letter\"]}"
    res,op = User::Create.run(user: attributes_for(:user, password: "test1"))
    res.must_equal false
    op.errors.to_s.must_equal "{:password=>[\"Passwords don't match\", \"must have at least: one number between 0 and 9; one Upper Case letter; one Lower Case letter\"]}"
    res,op = User::Create.run(user: attributes_for(:user, password: "TEST1"))
    res.must_equal false
    op.errors.to_s.must_equal "{:password=>[\"Passwords don't match\", \"must have at least: one number between 0 and 9; one Upper Case letter; one Lower Case letter\"]}"
  end

  it "email format fails" do
    res,op = User::Create.run(user: attributes_for(:user, email: "@email.com"))
    res.must_equal false
    op.errors.to_s.must_equal "{:email=>[\"is invalid\"]}"
    res,op = User::Create.run(user: attributes_for(:user, email: "testemail.com"))
    res.must_equal false
    op.errors.to_s.must_equal "{:email=>[\"is invalid\"]}"
    res,op = User::Create.run(user: attributes_for(:user, email: "test@emailcom"))
    res.must_equal false
    op.errors.to_s.must_equal "{:email=>[\"is invalid\"]}"
    res,op = User::Create.run(user: attributes_for(:user, email: "test@.com"))
    res.must_equal false
    op.errors.to_s.must_equal "{:email=>[\"is invalid\"]}"
  end

  it "wrong age" do
    res,op = User::Create.run(user: attributes_for(:user, age: ""))
    res.must_equal false
    op.errors.to_s.must_equal "{:age=>[\"is not a number\"]}"
    res,op = User::Create.run(user: attributes_for(:user, age: "0"))
    res.must_equal false
    op.errors.to_s.must_equal "{:age=>[\"must be greater than 0\"]}"
    res,op = User::Create.run(user: attributes_for(:user, age: "25.5"))
    res.must_equal false
    op.errors.to_s.must_equal "{:age=>[\"must be an integer\"]}"
  end

end
