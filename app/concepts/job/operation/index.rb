class Job < ActiveRecord::Base
  class Index < Trailblazer::Operation
    def model!(params)
      Job.all
    end
  end
  
end