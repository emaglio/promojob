class UsersController < ApplicationController
    
	def new
		form User::Create
		render
	end

	def create
		run User::Create do |op|
			return redirect_to op.model
		end

		render :new
	end

	def show
		present User::Update
	end

	def edit
		form User::Update
	end

	def update
		run User::Update do |op|
			return redirect_to op.model
		end
	end
	

end