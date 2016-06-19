class JobApplication < ActiveRecord::Base

  class Edit < Apply

    model JobApplication, :find

    policy Session::Policy, :admin?
    
  end

end