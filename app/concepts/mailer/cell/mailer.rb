module Mailer::Cell

  class JobAppUpdate < Trailblazer::Cell
    def hired?
      return model[:job_application][:status] == "Hire"
    end

    def user
      job_app = ::JobApplication.find(model[:id])
      return user = ::User.find(job_app.user_id)
    end

    def job
      job_app = ::JobApplication.find(model[:id])
      return job = ::Job.find(job_app.job_id)
    end

    def job_app
      return job_app = ::JobApplication.find(model[:id])
    end
  end

  class Welcome < Trailblazer::Cell
    def user_firstname
      model[:user][:firstname]
    end
  end

  class Footer < Trailblazer::Cell

  end

  class Apply < Trailblazer::Cell
    def user
      return user = ::User.find(model[:user_id])
    end    

    def job
      return job = ::Job.find(model[:job_id])
    end
  end


end