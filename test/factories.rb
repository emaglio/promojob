FactoryGirl.define  do

  factory :user do
    firstname "Ema"
    lastname "Maglio"
    gender "Male"
    age "30"
    email "my@email.com"
    phone "0410123456"
    password "Test1"
    confirm_password "Test1"
    block false
  end

  factory :job do
    title "AppSpec"
    company "Nick's"
    requirements "Beeing cool"
    description "Showing hasses"
    user_count "1"
    salary "100 $/hour"
    starts_at "01-02-2016 12:12"
    ends_at "02-02-2016 12:12"
  end

end

