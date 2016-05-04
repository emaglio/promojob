class Job < ActiveRecord::Base
  class Apply < Trailblazer::Operation
    include Model
    model JobApplication, :create

    contract do
      property :job_id
      property :user_id
      property :status
      property :message
      validates :job_id, :user_id, presence: true # maybe no sense
    end

    def process(params)
      validate(params)do
        contract.save
      end
    end

  end
end
