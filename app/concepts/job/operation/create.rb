class Job < ActiveRecord::Base
	class Create < Trailblazer::Operation
	    include Model
	    model Job, :create
	    
	    #only the admin can create a job
	    policy Session::Policy, :admin?

	    contract do
	    	property :title
	    	property :company
	    	property :requirements
	    	property :description
	    	property :salary
	    	property :starts_at

	    	validates :title, :requirements, :description , presence: true
	    end

	    def process(params)
	    	validate(params[:job]) do
	    		contract.save
	    	end

	    end

	end
end
