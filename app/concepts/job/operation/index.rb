class Job < ActiveRecord::Base
  class Index < Trailblazer::Operation
    policy Session::Policy, :create?

    def model!(params)
      Job.all
    end
  end

end
