class User < ActiveRecord::Base
  class Delete < Trailblazer::Operation

    #only admin can see all the users
    policy Session::Policy, :admin?
    
    def model!(params)
      User.all
    end
  
  end
end