module JobApplication::Cell

  class Applications < Trailblazer::Cell
  private
    def header
      statuses = {
        "Apply" => "Applied Jobs",
        "Hire" => "Hired Jobs",
        "Reject" => "Rejected Jobs"
      }

      statuses[options[:status]]
    end
    
    def total
      model.size
    end
  end

  class JobApplication < Trailblazer::Cell

    def link
      link_to Job.find(model.job_id).title, edit_job_application_path(model)
    end

    def delete_link
      link_to "Delete", job_application_path(model), method: :delete, class: 'alert button', data: {confirm: "Are you sure?"}
    end
  
  end      
end