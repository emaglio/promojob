class UsersController < ApplicationController

	def new
		form User::Create
		render User::Cell::New, model: @form
	end

	def create
		run User::Create do |op|
			return redirect_to op.model
		end

		render User::Cell::New, model: @form
	end

	def show
		present User::Update

		render User::Cell::Show
	end

	def edit
		form User::Update

		render User::Cell::Edit, model: @form
	end

	def update
		#TODO: adding flash message
		run User::Update do |op|
			return redirect_to op.model
		end

		render User::Cell::Edit, model: @form
	end
	

	def index
		present User::Index

		render User::Cell::Index
	end

	def destroy
		#TODO: adding flash message
		run User::Delete do
			redirect_to root_path
		end
	end

end
