class JobsController < ApplicationController

	def index
		present	Job::Index
		render Job::Cell::Index
	end

	def new
		form Job::Create
		render Job::Cell::New, model: @form
	end

	def create
		run Job::Create do |op|
			return redirect_to "/jobs"
		end

		render Job::Cell::New, model: @form
	end

	def show
		present Job::Update
		render Job::Cell::Show
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
