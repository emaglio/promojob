class JobApplication < ActiveRecord::Base
  class Applications < Trailblazer::Operation 
    
    policy Session::Policy, :admin?


    def model!(params)
      JobApplication.where(status: params[:status])
    end
  
  end
end