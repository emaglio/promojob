module JobApplication::Cell

  class Edit < Trailblazer::Cell
    include ActionView::RecordIdentifier
    include SimpleForm::ActionViewExtensions::FormHelper
    include ActionView::Helpers::FormOptionsHelper

    property :message
    property :job
    property :user
    
  end
end