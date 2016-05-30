class Job < ActiveRecord::Base
  class Index < Trailblazer::Operation
    
    #anyone can see the job list
    policy Session::Policy, :true?

    def model!(params)
      Job.all
    end
  end

end
