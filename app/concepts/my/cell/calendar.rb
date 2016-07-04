require "date"

module  My::Cell

  module Tyrant
    def tyrant
      context[:tyrant]
    end
  end
  
  class Calendar < Trailblazer::Cell
    def offset
      options[:offset]
    end
    
    def week_days
      ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    end

    def month #CHANGE THIS
       DateTime.now.strftime("%B")
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

    def show
      today = DateTime.now
      monday = today - today.cwday + options[:week]*7
      week = [monday+1]
      6.times do |i| 
        week << (week.last + 1)
      end

      week[0] = week.last.change(:hour => 0, :min => 0)
      week[6] = week.last.change(:hour => 23, :min => 59)

      cell(Day, collection: week)
    end

    class Day < Trailblazer::Cell
      
      def day
        model
      end
    end
  end
  
  class Jobs < Trailblazer::Cell

    def show
      today = DateTime.now
      monday = today - today.cwday + options[:week]*7
      week = [monday+1]
      6.times do |i| 
        week << week.last + 1 
      end

      week[0] = week.last.change(:hour => 0, :min => 0)
      week[6] = week.last.change(:hour => 23, :min => 59)

      # job_apps = ::Job.where("starts_at BETWEEN ? AND ?", week.first, week.last)

      job_apps = ::Job.all

      cell(Job, collection: job_apps)
    end

    class Job < Trailblazer::Cell 
      include Tyrant
      def job
        model.title
      end
    end
  end
end