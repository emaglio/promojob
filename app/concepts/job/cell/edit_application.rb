module Job::Cell

  class EditApplication < Trailblazer::Cell
    include ActionView::RecordIdentifier
    include SimpleForm::ActionViewExtensions::FormHelper
    include ActionView::Helpers::FormOptionsHelper

    property :message


    def getJob
      Job.find(model.job_id)
    end

    def getUser #TODO change to User.where to get the list of users
      User.find(model.user_id)
    end

  end
end