class Job < ActiveRecord::Base
	class Create < Trailblazer::Operation # =>Job::Create 
	    include Module
	    model Job, :create

	    contract do
	    	property :jobtitle
	    	property :company
	    	property :requirements
	    	property :description
	    	property :salary

	    	validates :jobtitle, :requirements, :description , presence: true
	    end

	    def process(params)
	    	validate(params[:job]) do
	    		contract.save
	    	end
	    end

	end
end