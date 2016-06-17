module Job::Cell

  class EditApplication < Trailblazer::Cell
    include ActionView::RecordIdentifier
    include SimpleForm::ActionViewExtensions::FormHelper
    include ActionView::Helpers::FormOptionsHelper

    property :message


    def job
      model.job
    end

    def user #TODO change to User.where to get the list of users
      model.user
    end

  end
end