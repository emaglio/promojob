module JobApplication::Cell

  class Edit < Trailblazer::Cell
    include ActionView::RecordIdentifier
    include SimpleForm::ActionViewExtensions::FormHelper
    include ActionView::Helpers::FormOptionsHelper
    raise job.inspect
    property :message
    property :job
    property :user
    
  end
end