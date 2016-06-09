module RailsFoundation
  module Cell
    class Message < Trailblazer::Cell
      include ActionView::Helpers::CsrfHelper
      # include ActionController::RequestForgeryProtection
      property :name
      property :msg

      def flash
        
      end

    end
  end
end