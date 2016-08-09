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
        positions_fulfilled(params[:job_application]) 
        contract.save
        # notify_user(params)
      end
    end

    def positions_fulfilled(params)
      return unless params[:status] == "Hire"
      hired_apps = JobApplication.where("job_id = ? AND status = ?", @model.job_id, "Hire").size
      positions = Job.find(@model.job_id).user_count.to_i
      raise Trailblazer::NotAuthorizedError if hired_apps >= positions #raise custom error
    end

    def notify_user(params)
      job_app = ::JobApplication.find(params[:id])
      user = job_app.user
      job = job_app.job

      body = {
        "Hire" => "You have been hired for for role of #{job.title}. See you at #{job.starts_at.strftime("%A - %d/%m/%Y at %H:%M")}",
        "Reject" => "Sorry but you have been reject for role of #{job.title}"
      }

      Pony.mail({ to: "emanuelem@cosmed.it", #user.email,
                  subject: "Application for the role of #{job.title}",
                  body: body[job_app.status],
                  html_body: ::Mailer::Cell::Email.new(params).()
                })
    end

  end
end