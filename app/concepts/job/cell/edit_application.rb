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
      # TODO: adding error message in case the User has not been found
      # flash[:message] = "User not found, probably the account has been deleted"
      # redirect_to 'job_applications/applied'
    end

  end
end