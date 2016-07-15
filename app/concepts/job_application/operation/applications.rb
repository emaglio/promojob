class JobApplication < ActiveRecord::Base
  class Applications < Trailblazer::Operation 
    
    policy Session::Policy, :admin?


    def model!(params)
      JobApplication.where(status: @status = params[:status])
    end
  
    attr_reader :status
  end
end