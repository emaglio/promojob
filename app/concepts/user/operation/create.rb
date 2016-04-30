class User < ActiveRecord::Base
  class Create < Trailblazer::Operation # => User::Create
      include Model
      model User, :create

      contract do
      	property :firstname
        property :lastname
        property :email
        property :gender
        property :phone
        property :password
        validates :firstname, :lastname, :gender , presence: true
        validates_uniqueness_of :phone
        validates_uniqueness_of :email


        validates :phone, length: {in: 10..10, message:"Double check your phone number please"}

        VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
        VALID_PASSWORD_REGEX = /(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])/
        
        validates :email, presence: true,
                  format: {with: VALID_EMAIL_REGEX}
    
        validates :password,  presence: true,
                              length: {in: 5..20, too_short: "must have at least 5 characters",
                              too_long: "must have at most 20 characters"},
                              format: {with: VALID_PASSWORD_REGEX, 
                              message: "must have at least: one number between 0 and 9; one Upper Case letter; one Lower Case letter"}  
      end

      def process(params)
      	validate(params[:user]) do
      		contract.save
      	end
        
      end
  
  end
end