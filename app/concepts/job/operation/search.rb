class Job < ActiveRecord::Base
  class Search < Trailblazer::Operation
    policy Session::Policy, :true?

    def model!(params)



    end

    def keyword
      Jobs.where("title.include?")
    end

  end
end