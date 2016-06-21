class JobApplication < ActiveRecord::Base

  class Update < Trailblazer::Operation
    include Model

    policy Session::Policy, :admin?

    model JobApplication, :find

    contract do
      property :status
    end

    def process(params)
      validate(params)do
        contract.save
      end
    end

  end

end