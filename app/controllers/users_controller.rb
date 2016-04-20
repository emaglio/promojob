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
		
	end

end