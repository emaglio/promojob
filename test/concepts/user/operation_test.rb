require 'test_helper'

class UserOperationTest < MiniTest::Spec
  
  let(:admin) {admin_for}
  
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
    op.errors.to_s.must_equal "{:age=>[\"can't be blank\", \"is not a number\"]}"
    res,op = User::Create.run(user: attributes_for(:user, age: "0"))
    res.must_equal false
    op.errors.to_s.must_equal "{:age=>[\"must be greater than 0\"]}"
    res,op = User::Create.run(user: attributes_for(:user, age: "25.5"))
    res.must_equal false
    op.errors.to_s.must_equal "{:age=>[\"must be an integer\"]}"
  end

  it "delete user" do
    user = User::Create.(user: attributes_for(:user, email: "delete@mail.com")).model
    user.persisted?.must_equal true

    op = User::Delete.({id: user.id, current_user: user})
    op.model.destroyed?.must_equal true

    user = User::Create.(user: attributes_for(:user, email: "delete@mail.com")).model
    user.persisted?.must_equal true

    op = User::Delete.({id: user.id, current_user: admin_for})
    op.model.destroyed?.must_equal true
  end

  it "can't delete user if not user or admin" do
    sneaky_user = User::Create.(user: attributes_for(:user)).model
    user = User::Create.(user: attributes_for(:user, email: "delete@mail.com", phone: "00")).model

    assert_raises Trailblazer::NotAuthorizedError do
      User::Delete.(
        id: user.id,
        current_user: sneaky_user)
    end

  end

  it "edit user" do
    user = User::Create.(user: attributes_for(:user)).model
    user.persisted?.must_equal true
    user.email.must_equal "my@email.com"

    user_edited = User::Update.(id: user.id, user: {email: "edited@mail.com", 
        password: "Test1", confirm_password: "Test1"}, current_user: user).model
    user_edited.persisted?.must_equal true
    user_edited.email.must_equal "edited@mail.com"
  end

  it "only admin block user" do
    user = User::Create.(user: attributes_for(:user)).model
    user.persisted?.must_equal true
    user.email.must_equal "my@email.com"

    assert_raises Trailblazer::NotAuthorizedError do
      User::Block.(
        id: user.id,
        block: true,
        current_user: user)
    end

    user_blocked = User::Block.(id: user.id, block: true, current_user: admin).model
    user_blocked.persisted?.must_equal true
    user_blocked.block.must_equal true

    user_un_blocked = User::Block.(id: user.id, block: false, current_user: admin).model
    user_un_blocked.persisted?.must_equal true
    user_un_blocked.block.must_equal false
    
  end

  # valid file upload.
  it "valid upload" do
    user = User::Create.(user: attributes_for(:user,
      profile_image: File.open("test/images/profile.jpeg"),
      cv: File.open("test/files/cv.pdf"))).model

    Paperdragon::Attachment.new(user.image_meta_data).exists?.must_equal true
    Paperdragon::Attachment.new(user.file_meta_data).exists?.must_equal true
    user = User::Delete.({id: user.id, current_user: user}).model
  end

  it "wrong file type" do
    res, op = User::Create.run(user: attributes_for(:user,
      profile_image: File.open("test/files/wrong_file.docx"),
      cv: File.open("test/files/wrong_file.docx")))
    res.must_equal false
    op.errors.to_s.must_equal "{:profile_image=>[\"Invalid format, file should be one of: *./jpeg, *./jpg and *./png\"], :cv=>[\"Invalid format, file can be one only a PDF\"]}"
    Paperdragon::Attachment.new(op.model.image_meta_data).exists?.must_equal false
    Paperdragon::Attachment.new(op.model.file_meta_data).exists?.must_equal false
  end

  it "file too big" do 
    res, op = User::Create.run(user: attributes_for(:user,
              cv: File.open("test/files/DLCO cal.pdf")))
    res.must_equal false
    op.errors.to_s.must_equal "{:cv=>[\"File too big, it must be less that 1 MB.\"]}"
    Paperdragon::Attachment.new(op.model.file_meta_data).exists?.must_equal false
  end

  it "delete user and image" do
    user = User::Create.(user: attributes_for(:user,
      profile_image: File.open("test/images/profile.jpeg"),
      cv: File.open("test/files/cv.pdf"))).model
    Paperdragon::Attachment.new(user.image_meta_data).exists?.must_equal true
    Paperdragon::Attachment.new(user.file_meta_data).exists?.must_equal true

    user = User::Delete.({id: user.id, current_user: user}).model
    user.destroyed?.must_equal true
    Paperdragon::Attachment.new(user.image_meta_data).exists?.must_equal false
    Paperdragon::Attachment.new(user.file_meta_data).exists?.must_equal false
  end
end
