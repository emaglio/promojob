class JobApplication < ActiveRecord::Base

  class Update < Trailblazer::Operation
    include Model
    
    policy Session::Policy, :admin?

    model JobApplication, :find

    contract do
      property :status
    end


    def process(params)
      validate(params[:job_application]) do
        positions_fulfilled(params[:job_application]) 
        contract.save
      end
    end

    def positions_fulfilled(params)
      return unless params[:status] == "Hire"
      hired_apps = JobApplication.where("job_id = ? AND status = ?", @model.job_id, "Hire").size
      positions = Job.find(@model.job_id).user_count.to_i
      raise Trailblazer::NotAuthorizedError if hired_apps >= positions
    end

  end
end