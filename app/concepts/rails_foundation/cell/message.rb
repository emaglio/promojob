module RailsFoundation
  module Cell
    class Message < Trailblazer::Cell
      include ActionView::Helpers::CsrfHelper
      # include ActionController::RequestForgeryProtection
      
    end
  end
end