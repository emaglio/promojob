class Job < ActiveRecord::Base

  class Search < Trailblazer::Operation

    policy Session::Policy, :true?

    def model!(params)
      keyword(params[:keyword])
    end

    def keyword(keyword)
      return Job.all if keyword.empty? 
      Job.where("title like ? or description like ?", keyword, keyword)
    end

  end
end