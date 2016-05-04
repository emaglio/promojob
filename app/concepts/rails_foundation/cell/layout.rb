module RailsFoundation
  module Cell
    class Layout < Trailblazer::Cell
      include ActionView::Helpers::CsrfHelper
      # include ActionController::RequestForgeryProtection
    end
  end
end
