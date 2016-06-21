class JobApplicationsController < ApplicationController

  def create
    run JobApplication::Apply do |op|
      flash[:notice] = "You have applied for #{Job.find(op.model.job_id).title}"
    end

    redirect_to "/jobs"
  end

  def show
    present JobApplication::Applied

    render JobApplication::Cell::Applied
  end

  def edit
    form JobApplication::Edit

    render JobApplication::Cell::Edit, model: @form
  end

  def update
    run JobApplication::Update do 
      flash[:success] = "Job application updated"
      return redirect_to "/job_applications/applied"
    end
    render JobApplication::Cell::Edit, model: @form
  end

  def destroy
    run JobApplication::Delete
    flash[:alert] = "Job application deleted"    
    redirect_to "/job_applications/applied"
  end

  def overview
    present JobApplication::Overview

    render JobApplication::Cell::Overview
  end

end
