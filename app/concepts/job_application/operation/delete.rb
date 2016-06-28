class JobApplication < ActiveRecord::Base
  class Delete < Trailblazer::Operation

    include Model
    policy Session::Policy, :delete?
    model JobApplication, :find

    def process(params) #TODO: do we need to destroy anything else?
      updateJobUserCount(params[:job_application][:job_id],params[:job_application][:status])
      model.destroy
    end
  
  end
end