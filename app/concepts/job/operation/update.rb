class Job < ActiveRecord::Base
	class Update < Create #=> Job::Create
		
		model Job, :find

    #only the admin can modify a Job
    policy Session::Policy, :apply?

	end  
end