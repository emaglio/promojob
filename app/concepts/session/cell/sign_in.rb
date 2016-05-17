module Session
  module Cell

    class SignIn < Trailblazer::Cell
      include ActionView::RecordIdentifier
      include SimpleForm::ActionViewExtensions::FormHelper
      include ActionView::Helpers::FormOptionsHelper
    end
  
  end
end