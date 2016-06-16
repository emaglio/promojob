class User < ActiveRecord::Base
  class Delete < Trailblazer::Operation

    include Model

    policy Session::Policy, :delete?
    model User, :find

    def process(params) #TODO: do we need to destroy anything else?
      deleteJobApplication(model)
      model.destroy
    end

    def deleteJobApplication(model)
      JobApplication.where("user_id = ?", model.id).find_each do |job_application|
       job_application.destroy
      end

    end
  
  end
end