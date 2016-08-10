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
  end

  class Welcome < Trailblazer::Cell

  end

  class Main < Trailblazer::Cell
    
  end

  class Header < Trailblazer::Cell
    
  end

  class Body < Trailblazer::Cell
    
  end

  class Footer < Trailblazer::Cell

  end


end