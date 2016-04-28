class JobsController < ApplicationController
    
	def new
		form Job::Create
		render
	end

	def create
		run Job::Create do |op|
			return redirect_to op.model
		end

		render :new
	end

	def show
		present Job::Update
	end

	def edit
		form Job::Update
	end

	def update
		run Job::Update do |op|
			return redirect_to op.model
		end
	end
	

end