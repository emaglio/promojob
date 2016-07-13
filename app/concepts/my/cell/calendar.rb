require "date"

module  My::Cell

  module Tyrant
    def tyrant
      context[:tyrant]
    end
  end

  module Policy
    def policy
      context[:policy]
    end
  end

  module MyWeek
    include Tyrant
    include Policy

    Day = Struct.new(:date, :job_statuses)
    JobStatus = Struct.new(:job, :application)

    def for_admin(jobs)
      jobs.collect do |j|
        applications = j.job_applications # job
        job_statuses = JobStatus.new(j, "#{applications.size} / #{j.user_count}")
      end
    end

    def for_user(jobs)
      jobs.collect do |j|
        application = ::JobApplication.where("user_id = ? AND job_id =?", tyrant.current_user.id, j.id).first
        job_statuses = JobStatus.new(j, application)
      end
    end

    def my_week
      today = options[:starts_at]
      monday = today - today.cwday + options[:week]*7
      monday = monday.change(:hour => 0, :min => 0)+1
      sunday = monday + 6
      week = []
      last = monday
      (monday..sunday).each do |day| 
        jobs = ::Job.where("DATE(starts_at) <= ? AND DATE(ends_at) >= ?", day.strftime("%F"), day.strftime("%F"))

        week << Day.new(last, policy.admin? ? for_admin(jobs) : for_user(jobs) ) 
        last += 1
      end

      return week
    end
  end
  
  class Calendar < Trailblazer::Cell
    def offset
      options[:offset]
    end
    
    def week_days
      ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    end

    def month #showing month of the first week + last week
      today = options[:starts_at]
      monday = today - today.cwday+1
      first_day = monday + offset*7
      last_day = monday + offset*7 + 28 - 1
      first_month = first_day.strftime("%B")
      last_month = last_day.strftime("%B")
      if first_month != last_month
        return first_month + " - " + last_month
      else
        return first_month
      end
    end

    def offset
      options[:offset]
    end
  end

  class WeekDay <Trailblazer::Cell
    def day
      model
    end
  end

  class Week < Trailblazer::Cell
    include MyWeek
    def show
      cell(Day, collection: my_week)
    end

    class Day < Trailblazer::Cell
      
      def day
        model.date.strftime("%d")
      end

      def today
        now = DateTime.now
        model.date.strftime("%F") == now.strftime("%F") ? "today" : "day"
      end

      def job_statuses
        model.job_statuses.collect do |job|
          job
        end
      end

      def decoration(job)
        statuses = {
        "Apply" => "fa fa-clock-o",
        "Hire" => "fa fa-check-circle-o",
        "Reject" => "fa fa-times"
        }
        statuses[job.application.status]
      end

    end
  end
end