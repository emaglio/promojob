FactoryGirl.define  do
  
  factory :user do
    firstname "Ema"
    lastname "Maglio"
    gender "Male"
    email "my@email.com"
    phone "0410123456"
    password "Test1"
  end

  factory :job do
    title "AppSpec"
    company "Nick's"
    requirements "Beeing cool"
    description "Showing hasses"
    salary "100 $/hour"
    startingday "12/12/12"
  end

end
    