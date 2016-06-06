class Job < ActiveRecord::Base
  class Edit < Create #=> Job::Create
    
    model Job, :find

    #only the admin can modify a Job
    policy Session::Policy, :admin?

  end  
end