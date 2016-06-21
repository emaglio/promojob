module JobApplication::Cell

  class Edit < Trailblazer::Cell
    include ActionView::RecordIdentifier
    include SimpleForm::ActionViewExtensions::FormHelper
    include ActionView::Helpers::FormOptionsHelper

    property :message
    property :job
    property :user


    def job
      raise model.id
      Job.find(model.job_id)
    end

    def user
      User.find(model.user_id)
    end
    
  end
end