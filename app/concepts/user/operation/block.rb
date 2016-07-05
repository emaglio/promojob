class User < ActiveRecord::Base

  class Block < Trailblazer::Operation 
    include Model

    policy Session::Policy, :admin?

    model User, :find

    contract do
      property :block
    end

    def process(params)
      validate(params)do
        contract.save
      end
    end
  end

end