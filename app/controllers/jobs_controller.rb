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
		present Job::Show
		render Job::Cell::Show
	end

	def edit
		form Job::Edit

		render Job::Cell::Edit, model: @form
	end

	def update
		run Job::Update do |op|
			flash[:success] = "Job #{op.model.title} has been uphbgghhghdated!"
			return redirect_to op.model
		end
	end

	def destroy
		#TODO: adding flash message
		run Job::Delete do
			redirect_to root_path
		end
	end

end
