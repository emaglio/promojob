class JobApplication < ActiveRecord::Base

  class Update < Trailblazer::Operation
    include Model

    policy Session::Policy, :update?

    model JobApplication, :find

    contract do
      property :status
    end

    def process(params)
      validate(params[:job_application]) do
        contract.save
      end
    end

  end

end