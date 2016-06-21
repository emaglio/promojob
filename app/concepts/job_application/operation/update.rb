class JobApplication < ActiveRecord::Base

  class Update < Trailblazer::Operation
    include Model
    policy Session::Policy, :admin?

    model JobApplication, :find?

    contract do
      property :status
    end

    def process(params)
      validate(params)do
        contract.save
      end
    end
    # def model!(params)#TODO: this is working but I don't know if I have used too much rails
    #   jobApp = JobApplication.find(params[:id])
    #   jobApp.status = params[:job_application][:status]
    #   jobApp.save
    # end

  end

end