class User < ActiveRecord::Base
  class Index < Trailblazer::Operation
    
    def model!(params)
      User.all
    end
  
  end
end