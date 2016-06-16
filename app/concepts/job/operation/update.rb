class Job < ActiveRecord::Base
	class Update < Create #=> Job::Create
		
		model Job, :find

    policy Session::Policy, :apply?

	end  
end