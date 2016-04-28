class Job < ActiveRecord::Base
	class Update < Create # => Job::Create
		
		model Job, :find
	
	end
  
end