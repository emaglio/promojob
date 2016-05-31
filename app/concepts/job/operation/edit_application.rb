class Job < ActiveRecord::Base

  class EditApplication < Apply

    policy Session::Policy, :admin?
    
    model JobApplication, :find

  end

end