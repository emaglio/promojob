module RailsFoundation
  module Cell
    class Footer < Trailblazer::Cell
      private
        def tyrant
          context[:tyrant]
        end
    end
  end
end
