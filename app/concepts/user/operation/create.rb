class User < ActiveRecord::Base
  class Create < Trailblazer::Operation # => User::Create
      include Model
      model User, :create

      contract do
      	property :firstname
      	validates :firstname, presence: true
      end

      def process(params)
      	validate(params[:user]) do
      		contract.save
      	end
      end
  
  end
end
