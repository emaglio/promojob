class Job < ActiveRecord::Base
  class DeleteApplication < Trailblazer::Operation

    include Model
    policy Session::Policy, :delete?
    model JobApplication, :find

    def process(params) #TODO: do we need to destroy anything else?
      model.destroy
    end
  
  end
end