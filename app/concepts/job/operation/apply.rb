class Job < ActiveRecord::Base
  class Apply < Trailblazer::Operation
    include Model
    model JobApplication, :create

    def process(params)
      model.update_attributes(params)
    end

  end
end
