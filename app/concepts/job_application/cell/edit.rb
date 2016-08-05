module JobApplication::Cell

  class Edit < Trailblazer::Cell
    include ActionView::RecordIdentifier
    include SimpleForm::ActionViewExtensions::FormHelper
    include ActionView::Helpers::FormOptionsHelper

    property :message
    property :job
    property :user

    def link_cv
      link_to "View CV", user.file[:original].url, data: { lightbox: "image", title: "CV" } if user.file.exists?
    end
    
  end
end