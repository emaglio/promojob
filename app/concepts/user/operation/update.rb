class User < ActiveRecord::Base
  class Update < Create

    policy Session::Policy, :edit?

    model User, :find
  
  end
  
end