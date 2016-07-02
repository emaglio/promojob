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
  end

  class Week < Trailblazer::Cell

    def show
      today = DateTime.now
      monday = today - today.cwday + options[:week]*7
      week = [monday+1]
      6.times do |i| 
        week << week.last + 1 
      end 
      
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
      
      job_apps = ::Job.where("starts_at BETWEEN ? AND ?", model, model)

      cell(Job, collection: job_apps)
    end

    class Job < Trailblazer::Cell 
      include Tyrant
      def job
        raise model.inspect
      end
    end
  end
end