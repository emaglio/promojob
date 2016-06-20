require_dependency "job_application/operation/edit"

class JobApplication < ActiveRecord::Base

  class Overview < Edit
    policy Session::Policy, :my?
  end
end