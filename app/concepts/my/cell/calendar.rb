require "date"

module  My::Cell

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
end