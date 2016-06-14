class Job < ActiveRecord::Base

  class Search < Trailblazer::Operation

    policy Session::Policy, :true?

    def model!(params)
      # Job.where("salary > ?", params[:lowSalary])
      getLowSalary!(Job.all, params[:lowSalary])
    end

    def getKeyword(job)
      return unless keyword.empty? 
      job.where("title.include?")
    end

    def getLowSalary!(job, lowSalary)
      return unless lowSalary.empty?
      job.where("salary > ?", lowSalary)
    end

    def getHighSalary(job)
      return unless highSalary.empty?
      job.where("salary < ?", highSalary)
    end

  end
end