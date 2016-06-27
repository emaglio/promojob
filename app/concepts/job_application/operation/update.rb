class JobApplication < ActiveRecord::Base

  class Update < Trailblazer::Operation
    include Model

    policy Session::Policy, :admin?

    model JobApplication, :find

    contract do
      property :status
    end

    def process(params)
      validate(params[:job_application]) do
        updateJobUserCount(params[:job_application][:job_id],params[:job_application][:status])
        contract.save
      end
    end

  end

  #when someone is hired the user_count decrease
  #user_cont = 0 --> all positions fullfilled 
  def updateJobUserCount(id, status)
    job = Job.find(id)
    if status == "Hire"
      job.user_count -= 1
    else
      job.user_count += 1
    job.save
  end

end