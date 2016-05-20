module RailsFoundation
  module Cell
    class Navigation < Trailblazer::Cell
    private
      def tyrant
        context[:tyrant]
      end
    end
  end
end
