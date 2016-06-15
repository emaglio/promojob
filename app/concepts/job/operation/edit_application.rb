class Job < ActiveRecord::Base

  class EditApplication < Apply
    
    model JobApplication, :find

    policy Session::Policy, :admin?
    
  end

end