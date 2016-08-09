module Job::Cell
  
  class Show < Trailblazer::Cell
    User = Struct.new(:user, :status)

    property :id
    property :title
    property :company
    property :requirements
    property :description
    property :duration
    property :user_count
    property :salary
    property :starts_at
    property :ends_at


    def users
      users_array = []
      applications = JobApplication.where("job_id = ?", id) 
      applications.each do |application|
        users_array << User.new(::User.find(application.user_id), application.status)
      end
      return users_array
    end

    def label
      if users.size == 0 
        return "No applicants for this job"
      else
        return "List of applicants:"
      end
    end
  end

  class Applicants <Trailblazer::Cell
    def link
      link_to model.user.email, model.user
    end

    def status
      statuses = {
        "Apply" => "In review:",
        "Hire" => "Hired:",
        "Reject" => "Rejected:"
        }
      statuses[model.status]
    end
  end


end
