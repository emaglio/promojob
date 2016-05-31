module Job::Cell

  class Applied < Trailblazer::Cell
  private
    def total
      model.size
    end
  end

  class JobApplication < Trailblazer::Cell

    def link
      link_to Job.find(model.job_id).title, edit_job_application_path(model)
    end
  
  end      
end