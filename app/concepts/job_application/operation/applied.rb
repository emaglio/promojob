class JobApplication < ActiveRecord::Base
  class Applied < Trailblazer::Operation 
    
    policy Session::Policy, :admin?


    def model!(params)
      JobApplication.where(status: "Applied")
    end
  
  end
end