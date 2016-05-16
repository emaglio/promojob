class SessionsController < ApplicationController
  
  def sign_in_form
    form Session::SignIn
    render Session::Cell:SignIn, @form
  end

end