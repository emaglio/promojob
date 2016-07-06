require "date"

module  My::Cell

  module Tyrant
    def tyrant
      context[:tyrant]
    end
  end

  module MyWeek
    def my_week
      today = DateTime.now
      monday = today - today.cwday + options[:week]*7
      monday = monday.change(:hour => 0, :min => 0)
      week = [monday+1]
      6.times do |i| 
        week << (week.last + 1) 
      end

      week[6] = week.last.change(:hour => 23, :min => 59)

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
      today = DateTime.now
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
        model
      end
    end
  end
  
  class Jobs < Trailblazer::Cell
    include MyWeek

    def show
      job_apps = ::Job.where("starts_at BETWEEN ? AND ?", my_week.first, my_week.last)

      cell(Job, collection: job_apps)
    end

    class Job < Trailblazer::Cell 
      include Tyrant
      def job
        model
      end
    end
  end
end