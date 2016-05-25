class User < ActiveRecord::Base
  class Update < Create

    policy Session::Policy, :admin?
      
    model User, :find
  
  end
  
end