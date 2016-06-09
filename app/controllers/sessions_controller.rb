class SessionsController < ApplicationController

  def new
    form Session::SignIn
    render Session::Cell::SignIn, model: @form
  end

  def create
    run Session::SignIn do |op|
      tyrant.sign_in!(op.model)
      flash[:message] = "Welcome!"
      return redirect_to jobs_path
    end

    render Session::Cell::SignIn, model: @form
  end

  def sign_out
    run Session::SignOut do
      tyrant.sign_out!
      redirect_to root_path
    end
  end
end
