class Job < ActiveRecord::Base
	class Create < Trailblazer::Operation # =>Job::Create 
	    include Model
	    model Job, :create

	    contract do
	    	property :title
	    	property :company
	    	property :requirements
	    	property :description
	    	property :salary
	    	property :startingday

	    	validates :title, :requirements, :description , presence: true
	    end

	    def process(params)
	    	validate(params[:job]) do
	    		contract.save
	    	end
	    	
	    end

	end
end