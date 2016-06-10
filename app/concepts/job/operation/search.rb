class Job < ActiveRecord::Base
  class Search < Trailblazer::Operation
    policy Session::Policy, :true?

    

  end
end