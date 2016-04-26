module RailsFoundation
  module Cell
    class Layout < Trailblazer::Cell
      include ActionView::Helpers::CsrfHelper
      # include ActionController::RequestForgeryProtection

      # delegates :parent_controller, :javascript_include_tag
      def javascript_include_tag(*args)
        ::ActionController::Base.helpers.javascript_include_tag(*args)
      end

      def stylesheet_link_tag(*args)
        ::ActionController::Base.helpers.stylesheet_link_tag(*args)
      end


      # def csrf_meta_tags(*args)
          # this doesn't work:
      #   # return parent_controller.csrf_meta_tags(*args)
          # because something is not properly included or something haha, it's so fucking messy.

      #   ::ActionController::Base.helpers.csrf_meta_tags(*args)
      # end

      def content
        @options[:content]
      end
    end
  end
end
