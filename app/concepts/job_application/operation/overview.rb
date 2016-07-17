require_dependency "job_application/operation/edit"

class JobApplication < ActiveRecord::Base

  class Overview < Edit
    policy Session::Policy, :current_user_application?
  end
end