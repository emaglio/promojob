class Job < ActiveRecord::Base
  class Delete < Trailblazer::Operation

    include Model
    policy Session::Policy, :admin?
    model Job, :find

    def process(params) #TODO: do we need to destroy anything else?
      deleteJobApplication(model)
      model.destroy
    end

    def deleteJobApplication(model)
      JobApplication.where("job_id = ?", model.id).find_each do |job_application|
       job_application.destroy
      end
    end
  
  end
end