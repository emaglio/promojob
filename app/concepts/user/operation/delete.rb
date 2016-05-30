class User < ActiveRecord::Base
  class Delete < Trailblazer::Operation

    include Model
    #only admin can see all the users
    policy Session::Policy, :delete?
    model User, :find

    def process(params) #TODO: do we need to destroy anything else?
      model.destroy
    end
  
  end
end