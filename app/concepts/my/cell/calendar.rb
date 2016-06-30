require "date"

module  My::Cell

  module Policy
    def policy
      context[:policy]
    end
  end

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
      
      def show
        model
        cell(Jobs, model)
      end

    end

    class Jobs < Trailblazer::Cell

      def show
        job_apps = Job.where(starts_at: model)

        cell(Job, collection: job_apps)
      end
      
    end

    class Job < Trailblazer::Cell 
      include Tyrant
      def job
        raise model.inspect
      end
    end

  end
end