class Job < ActiveRecord::Base
  class Show < Create #=> Job::Create
    
    model Job, :find

    policy Session::Policy, :apply?

  end  
end