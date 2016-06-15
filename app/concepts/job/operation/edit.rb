class Job < ActiveRecord::Base
  class Edit < Create #=> Job::Create
    
    model Job, :find

    policy Session::Policy, :admin?

  end  
end