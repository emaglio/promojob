class JobApplication < ActiveRecord::Base

  class Update < Trailblazer::Operation
    include Model

    policy Session::Policy, :admin? and :positions_fulfilled?

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