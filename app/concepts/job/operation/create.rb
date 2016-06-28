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
	    	property :user_count

	    	validates :title, :requirements, :description , presence: true
	    	validates :user_count, numericality: { only_integer: true, greater_than: 0}
	    end

	    def process(params)
	    	validate(params[:job]) do
	    		contract.save
	    	end

	    end
	end
end
