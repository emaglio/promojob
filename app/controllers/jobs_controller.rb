class JobsController < ApplicationController

	def index
		present	Job::Index
		render Job::Cell::Index
    # render Mailer::Cell::Email
	end

	def new
		form Job::Create
		render Job::Cell::New, model: @form
	end

	def create
		run Job::Create do |op|
			flash[:notice] = "#{op.model.title} job has been created"
			return redirect_to "/jobs"
		end

		render Job::Cell::New, model: @form
	end

	def show
		present Job::Show
		render Job::Cell::Show
	end

	def edit
		form Job::Edit

		render Job::Cell::Edit, model: @form
	end

	def update
		run Job::Update do |op|
			flash[:notice] = "Job #{op.model.title} has been updated"
			return redirect_to op.model
		end

		render Job::Cell::Edit, model: @form
	end

	def search
		present Job::Search
		render Job::Cell::Index
	end

	def destroy
		run Job::Delete do
			flash[:alert] = "Job deleted"
			redirect_to root_path
		end
	end

2end
