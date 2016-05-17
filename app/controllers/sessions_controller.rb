class SessionsController < ApplicationController
  
  def new
    form Session::SignIn
    render Session::Cell::SignIn, @form
  end

  def create
    run Session::SignIn do |op|
      tyrant.sign_in!(op.model)
      return redirect_to root_path
    end

    render Session::Cell::SignIn, @form
  end

end