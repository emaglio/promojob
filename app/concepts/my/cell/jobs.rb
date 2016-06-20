module My::Cell

  module Tyrant
    def tyrant
      context[:tyrant]
    end
  end

  class Jobs < Trailblazer::Cell

  end

  class Applications < Trailblazer::Cell
    include Tyrant

    def show
      job_apps = JobApplication.where(user_id: tyrant.current_user.id, status: options[:status])

      # job_apps.collect do |job_app|
      #   link_to job_app.job.title, edit_job_application_path(job_app.job)
      # end.join("")

      cell(Item, collection: job_apps)
    end

    # def delete_link
    #   link_to "Delete", job_application_path(model), method: :delete, class: 'alert button', data: {confirm: "Are you sure?"}
    # end
  
    class Item < Trailblazer::Cell 
      
    end
  end

end