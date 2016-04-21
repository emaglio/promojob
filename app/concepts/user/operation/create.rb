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
        validates :firstname, :lastname, :gender, :email, :phone , presence: true
        validates_uniqueness_of :phone
        validates_uniqueness_of :email  
        #would be good to put validate for the length of the phone and format of the email
      end

      def process(params)
      	validate(params[:user]) do
      		contract.save
      	end
      end
  
  end
end

'''
validates :phone, :email, unique: true 
'''