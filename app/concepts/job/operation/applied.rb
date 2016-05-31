class Job < ActiveRecord::Base
  class Applied < Trailblazer::Operation 
    
    policy Session::Policy, :admin?

    def model!(params)
      # JobApplication.where(status: "Applied")
      JobApplication.all
    end
  
  end
end