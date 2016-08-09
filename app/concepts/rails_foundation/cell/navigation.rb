module RailsFoundation
  module Cell
    class Navigation < Trailblazer::Cell
    private
      def tyrant
        context[:tyrant]
      end
      
      def num_apply
        ::JobApplication.where("status == ?", "Apply").size
      end

      def num_hire
        ::JobApplication.where("status == ?", "Hire").size
      end

      def num_reject
        ::JobApplication.where("status == ?", "Reject").size
      end

    end


  end
end
