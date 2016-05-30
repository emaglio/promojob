class User < ActiveRecord::Base
  class Update < Create

    policy Session::Policy, :admin?
    policy Session::Policy, :current_user?

    model User, :find
  
  end
  
end