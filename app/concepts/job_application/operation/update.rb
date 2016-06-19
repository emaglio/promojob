class JobApplication < ActiveRecord::Base

  class Update < Trailblazer::Operation

    policy Session::Policy, :admin?

    def model!(params)#TODO: this is working but I don't know if I have used too much rails
      jobApp = JobApplication.find(params[:id])
      jobApp.status = params[:job_application][:status]
      jobApp.save
    end

  end

end