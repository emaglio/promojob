FactoryGirl.define  do

  factory :user do
    firstname "Ema"
    lastname "Maglio"
    gender "Male"
    email "my@email.com"
    phone "0410123456"
    password "Test1"
    confirm_password "Test1"
  end

  factory :job do
    title "AppSpec"
    company "Nick's"
    requirements "Beeing cool"
    description "Showing hasses"
    salary "100 $/hour"
    starts_at "01-02-2016 12:12"
  end

  # factory :admin do
  #   firstname "CJ"
  #   lastname "Kühn"
  #   gender "Female"
  #   email "info@cj-agency.de"
  #   phone "0123456789"
  #   password "Test1234"
  #   confirm_password "Test1234"
  # end
end

