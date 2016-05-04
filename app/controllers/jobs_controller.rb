class JobsController < ApplicationController
    
	def index
		present	Job::Index
		render Job::Cell::Index, @model
	end

	def new
		form Job::Create
		render Job::Cell::New, @form
	end

	def create
		run Job::Create do |op|
			return redirect_to op.model
		end

		render Job::Cell::Create, @form
	end

	def show
		present Job::Update
		render Job::Cell::Show, @model
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