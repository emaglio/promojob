class Job < ActiveRecord::Base

  class UpdateApplication < Trailblazer::Operation
 
    policy Session::Policy, :admin?

    def model!(params)#TODO: this is working but I don't know if I have used too much rails
      job = JobApplication.find(params[:id])
      job.status = params[:job_application][:status]
      job.save
    end

  end

end