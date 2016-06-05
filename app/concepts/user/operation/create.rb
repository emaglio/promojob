require "reform/form/validation/unique_validator"
require "tyrant/sign_up"


class User < ActiveRecord::Base
  class Create < Tyrant::SignUp::Confirmed # => User::Create
      include Model
      model User, :create

      policy Session::Policy, :create?

      contract do
      	property :firstname
        property :lastname
        property :email
        property :gender
        property :phone
        # property :password
        validates :firstname, :lastname, :gender , :phone, presence: true
        validates :phone, :email, unique: true

        VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
        VALID_PASSWORD_REGEX = /(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])/
        
        validates :email, format: {with: VALID_EMAIL_REGEX}
    
        validates :password,  length: {in: 5..20, too_short: "must have at least 5 characters",
                              too_long: "must have at most 20 characters"},
                              format: {with: VALID_PASSWORD_REGEX, 
                              message: "must have at least: one number between 0 and 9; one Upper Case letter; one Lower Case letter"}  
      end

  end
end