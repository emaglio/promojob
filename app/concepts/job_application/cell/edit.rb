module JobApplication::Cell

  class Edit < Trailblazer::Cell
    include ActionView::RecordIdentifier
    include SimpleForm::ActionViewExtensions::FormHelper
    include ActionView::Helpers::FormOptionsHelper

    property :message


    def job
      Job.find(model.job_id)
    end

    def user #TODO change to User.where to get the list of users
      User.find(model.user_id)
    end

  end
end